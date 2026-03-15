namespace :breweries do
  desc "Fetch Apple Maps snapshots for breweries"
  task fetch_maps: :environment do
    require "net/http"
    require "jwt"
    require "openssl"

    creds = Rails.application.credentials.dig(:apple, :maps)
    abort "Set apple.maps in Rails credentials (team_id, key_id, private_key)" unless creds

    team_id = creds[:team_id]
    key_id = creds[:key_id]
    private_key = OpenSSL::PKey::EC.new(creds[:private_key])

    token = generate_maps_token(team_id, key_id, private_key)

    neighborhood_data = precompute_neighborhoods

    breweries = Brewery.visible.where.not(latitude: nil, longitude: nil)
      .where.missing(:map_light_attachment)
      .ordered
    puts "Fetching maps for #{breweries.count} breweries..."

    fetched = 0
    skipped = 0

    breweries.find_each do |brewery|
      data = neighborhood_data[brewery.neighborhood_id]
      zoom = data ? data[:zoom] : 14
      center = data ? "#{data[:center_lat]},#{data[:center_lng]}" : "#{brewery.latitude},#{brewery.longitude}"

      variants = {
        map_light: fetch_snapshot(token, center: center, color_scheme: "light", zoom: zoom, annotations: single_pin(brewery)),
        map_dark: fetch_snapshot(token, center: center, color_scheme: "dark", zoom: zoom, annotations: single_pin(brewery)),
        map_mobile_light: fetch_snapshot(token, center: center, color_scheme: "light", zoom: zoom, annotations: single_pin(brewery)),
        map_mobile_dark: fetch_snapshot(token, center: center, color_scheme: "dark", zoom: zoom, annotations: single_pin(brewery))
      }

      if variants.values.any?(&:nil?)
        puts "  SKIP #{brewery.name} (snapshot failed)"
        skipped += 1
        next
      end

      variants.each do |name, image_data|
        brewery.public_send(name).attach(
          io: StringIO.new(image_data),
          filename: "#{brewery.open_brewery_db_id}_#{name}.png",
          content_type: "image/png"
        )
      end

      puts "  OK   #{brewery.name} (#{brewery.neighborhood.name}, zoom #{zoom})"
      fetched += 1

      sleep 0.1
    end

    puts "Fetched #{fetched} brewery maps, skipped #{skipped}."
  end
end

namespace :neighborhoods do
  desc "Fetch Apple Maps snapshots for neighborhoods"
  task fetch_maps: :environment do
    require "net/http"
    require "jwt"
    require "openssl"

    creds = Rails.application.credentials.dig(:apple, :maps)
    abort "Set apple.maps in Rails credentials (team_id, key_id, private_key)" unless creds

    team_id = creds[:team_id]
    key_id = creds[:key_id]
    private_key = OpenSSL::PKey::EC.new(creds[:private_key])

    token = generate_maps_token(team_id, key_id, private_key)

    neighborhood_data = precompute_neighborhoods

    neighborhoods = Neighborhood.where.missing(:map_light_attachment).ordered
    puts "Fetching maps for #{neighborhoods.count} neighborhoods..."

    fetched = 0
    skipped = 0

    neighborhoods.each do |neighborhood|
      data = neighborhood_data[neighborhood.id]
      unless data
        puts "  SKIP #{neighborhood.name} (no breweries with coordinates)"
        skipped += 1
        next
      end

      center = "#{data[:center_lat]},#{data[:center_lng]}"
      annotations = multi_pin(neighborhood)

      variants = {
        map_light: fetch_snapshot(token, center: center, color_scheme: "light", zoom: data[:zoom], annotations: annotations),
        map_dark: fetch_snapshot(token, center: center, color_scheme: "dark", zoom: data[:zoom], annotations: annotations)
      }

      if variants.values.any?(&:nil?)
        puts "  SKIP #{neighborhood.name} (snapshot failed)"
        skipped += 1
        next
      end

      variants.each do |name, image_data|
        neighborhood.public_send(name).attach(
          io: StringIO.new(image_data),
          filename: "#{neighborhood.name.parameterize}_#{name}.png",
          content_type: "image/png"
        )
      end

      puts "  OK   #{neighborhood.name} (#{neighborhood.breweries.count} pins, zoom #{data[:zoom]})"
      fetched += 1

      sleep 0.1
    end

    puts "Fetched #{fetched} neighborhood maps, skipped #{skipped}."
  end
end

def precompute_neighborhoods
  Neighborhood.includes(:breweries).each_with_object({}) do |neighborhood, hash|
    breweries = neighborhood.breweries.where.not(latitude: nil, longitude: nil)
    next if breweries.empty?

    lats = breweries.pluck(:latitude).map(&:to_f)
    lngs = breweries.pluck(:longitude).map(&:to_f)
    center_lat = lats.sum / lats.size
    center_lng = lngs.sum / lngs.size

    max_distance = breweries.map { |b|
      [ (b.latitude.to_f - center_lat).abs, (b.longitude.to_f - center_lng).abs ].max
    }.max

    zoom = if max_distance < 0.02
      14
    elsif max_distance < 0.04
      13
    elsif max_distance < 0.08
      12
    else
      11
    end

    hash[neighborhood.id] = { center_lat: center_lat, center_lng: center_lng, zoom: zoom }
  end
end

def generate_maps_token(team_id, key_id, private_key)
  header = { alg: "ES256", kid: key_id, typ: "JWT" }
  payload = { iss: team_id, iat: Time.now.to_i, exp: 30.minutes.from_now.to_i }
  JWT.encode(payload, private_key, "ES256", header)
end

def single_pin(brewery)
  [ { point: "#{brewery.latitude},#{brewery.longitude}", color: "34a853", markerStyle: "balloon" } ].to_json
end

def multi_pin(neighborhood)
  breweries = neighborhood.breweries.where.not(latitude: nil, longitude: nil)

  # Apple Maps Snapshots API caps annotations at 10.
  # When a neighborhood has more, keep the most spread-out pins so the
  # map still conveys the full area.
  if breweries.size > 10
    lats = breweries.pluck(:latitude).map(&:to_f)
    lngs = breweries.pluck(:longitude).map(&:to_f)
    center_lat = lats.sum / lats.size
    center_lng = lngs.sum / lngs.size

    breweries = breweries.sort_by { |b|
      -[ (b.latitude.to_f - center_lat).abs, (b.longitude.to_f - center_lng).abs ].max
    }.first(10)
  end

  breweries.map { |b|
    { point: "#{b.latitude},#{b.longitude}", color: "34a853", markerStyle: "dot" }
  }.to_json
end

def fetch_snapshot(token, center:, color_scheme: "light", zoom: 14, size: "640x240", annotations: "[]")
  params = {
    center: center,
    z: zoom,
    size: size,
    scale: 2,
    t: "mutedStandard",
    colorScheme: color_scheme,
    annotations: annotations,
    token: token
  }

  uri = URI("https://snapshot.apple-mapkit.com/api/v1/snapshot?#{URI.encode_www_form(params)}")

  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true

  request = Net::HTTP::Get.new(uri)
  response = http.request(request)

  if response.is_a?(Net::HTTPSuccess) && response.content_type&.include?("image")
    response.body
  else
    puts "    Error: #{response.code} #{response.body&.first(200)}"
    nil
  end
end
