namespace :breweries do
  desc "Fetch brewery photos from Google Places API"
  task fetch_photos: :environment do
    require "net/http"
    require "json"

    api_key = Rails.application.credentials.dig(:google, :places_api_key)
    abort "Set google.places_api_key in Rails credentials" if api_key.blank?

    breweries = Brewery.where.missing(:photo_attachment).ordered
    puts "Fetching photos for #{breweries.count} breweries..."

    fetched = 0
    skipped = 0

    breweries.find_each do |brewery|
      place_id = find_place_id(brewery, api_key)
      unless place_id
        puts "  SKIP #{brewery.name} (no Google Places match)"
        skipped += 1
        next
      end

      photo_info = fetch_photo_info(place_id, api_key)
      unless photo_info
        puts "  SKIP #{brewery.name} (no photo available)"
        skipped += 1
        next
      end

      photo_data = download_photo(photo_info[:name], api_key)
      unless photo_data
        puts "  SKIP #{brewery.name} (photo download failed)"
        skipped += 1
        next
      end

      brewery.photo.attach(
        io: StringIO.new(photo_data),
        filename: "#{brewery.open_brewery_db_id}.jpg",
        content_type: "image/jpeg"
      )
      brewery.update!(photo_attribution: photo_info[:attribution])

      puts "  OK   #{brewery.name} (#{photo_info[:attribution] || "no attribution"})"
      fetched += 1

      sleep 0.1 # be polite to the API
    end

    puts "Fetched #{fetched} photos, skipped #{skipped}."
  end
end

def find_place_id(brewery, api_key)
  query = "#{brewery.name} brewery Portland OR"
  uri = URI("https://places.googleapis.com/v1/places:searchText")

  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true

  request = Net::HTTP::Post.new(uri)
  request["Content-Type"] = "application/json"
  request["X-Goog-Api-Key"] = api_key
  request["X-Goog-FieldMask"] = "places.id"

  request.body = { textQuery: query }.to_json

  response = http.request(request)
  return nil unless response.is_a?(Net::HTTPSuccess)

  data = JSON.parse(response.body)
  data.dig("places", 0, "id")
end

def fetch_photo_info(place_id, api_key)
  uri = URI("https://places.googleapis.com/v1/places/#{place_id}")

  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true

  request = Net::HTTP::Get.new(uri)
  request["X-Goog-Api-Key"] = api_key
  request["X-Goog-FieldMask"] = "photos"

  response = http.request(request)
  return nil unless response.is_a?(Net::HTTPSuccess)

  data = JSON.parse(response.body)
  photo = data.dig("photos", 0)
  return nil unless photo

  attribution = photo.dig("authorAttributions", 0, "displayName")
  { name: photo["name"], attribution: attribution }
end

def download_photo(photo_name, api_key)
  uri = URI("https://places.googleapis.com/v1/#{photo_name}/media?maxWidthPx=800&skipHttpRedirect=true")

  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true

  request = Net::HTTP::Get.new(uri)
  request["X-Goog-Api-Key"] = api_key

  response = http.request(request)
  return nil unless response.is_a?(Net::HTTPSuccess)

  data = JSON.parse(response.body)
  photo_uri = data["photoUri"]
  return nil unless photo_uri

  Net::HTTP.get(URI(photo_uri))
end
