# Dev user for local testing and smoke tests.
# The apple_uid matches what OmniAuth's developer provider sends (the email).
User.find_or_create_by!(email: "demo@beervana.test") do |u|
  u.apple_uid = "demo@beervana.test"
  u.name = "Demo User"
end

# 10 Portland breweries across 2 neighborhoods, with full data.
# No external API calls required.

neighborhoods = {
  central_eastside: Neighborhood.find_or_create_by!(name: "Central Eastside") { |n| n.position = 1 },
  pearl_district: Neighborhood.find_or_create_by!(name: "Pearl District") { |n| n.position = 2 }
}

breweries = [
  # --- Central Eastside ---
  {
    open_brewery_db_id: "3486d742-3bd5-449a-b66e-d3a881c3c103",
    name: "Wayfinder Beer",
    brewery_type: "brewpub",
    street: "304 SE 2nd Ave",
    city: "Portland",
    state: "Oregon",
    postal_code: "97214",
    phone: "5037181532",
    website_url: "https://www.wayfinder.beer",
    latitude: 45.5196370,
    longitude: -122.6612240,
    neighborhood: neighborhoods[:central_eastside],
    hours: "Sun-Thu 12pm-9pm, Fri-Sat 12pm-10pm",
    happy_hour: "Wed-Thu 3-5pm",
    food: "Full kitchen",
    outdoor_seating: true,
    dog_friendly: false,
    kid_friendly: true,
    wifi: false
  },
  {
    open_brewery_db_id: "hair-of-the-dog-brewing-portland",
    name: "Hair of the Dog Brewing",
    brewery_type: "micro",
    street: "61 SE Yamhill St",
    city: "Portland",
    state: "Oregon",
    postal_code: "97214",
    phone: "5032326585",
    website_url: "https://www.hairofthedog.com",
    latitude: 45.5152000,
    longitude: -122.6622000,
    neighborhood: neighborhoods[:central_eastside],
    hours: "Wed-Sun 12pm-8pm",
    food: "Snacks",
    outdoor_seating: true,
    dog_friendly: true,
    kid_friendly: false,
    wifi: true
  },
  {
    open_brewery_db_id: "base-camp-brewing-portland",
    name: "Base Camp Brewing",
    brewery_type: "micro",
    street: "930 SE Oak St",
    city: "Portland",
    state: "Oregon",
    postal_code: "97214",
    phone: "5034779381",
    website_url: "https://www.basecampbrewingco.com",
    latitude: 45.5188000,
    longitude: -122.6563000,
    neighborhood: neighborhoods[:central_eastside],
    hours: "Mon-Thu 3pm-9pm, Fri 12pm-10pm, Sat-Sun 12pm-9pm",
    food: "Food carts on-site",
    outdoor_seating: true,
    dog_friendly: true,
    kid_friendly: true,
    wifi: true
  },
  {
    open_brewery_db_id: "cascade-brewing-barrel-house-portland",
    name: "Cascade Brewing Barrel House",
    brewery_type: "micro",
    street: "939 SE Belmont St",
    city: "Portland",
    state: "Oregon",
    postal_code: "97214",
    phone: "5032657557",
    website_url: "https://www.cascadebrewing.com",
    latitude: 45.5168000,
    longitude: -122.6558000,
    neighborhood: neighborhoods[:central_eastside],
    hours: "Sun-Thu 12pm-9pm, Fri-Sat 12pm-10pm",
    food: "Small plates",
    outdoor_seating: true,
    dog_friendly: true,
    kid_friendly: true,
    wifi: true,
    events: "Sour beer tastings"
  },
  {
    open_brewery_db_id: "baerlic-brewing-portland",
    name: "Baerlic Brewing",
    brewery_type: "micro",
    street: "2235 SE 11th Ave",
    city: "Portland",
    state: "Oregon",
    postal_code: "97214",
    phone: "5039262580",
    website_url: "https://www.baerlicbrewing.com",
    latitude: 45.5047000,
    longitude: -122.6546000,
    neighborhood: neighborhoods[:central_eastside],
    hours: "Mon-Thu 3pm-9pm, Fri-Sat 12pm-10pm, Sun 12pm-8pm",
    food: "Food carts on-site",
    outdoor_seating: true,
    dog_friendly: true,
    kid_friendly: true,
    wifi: true,
    events: "Trivia night"
  },

  # --- Pearl District ---
  {
    open_brewery_db_id: "deschutes-brewery-portland",
    name: "Deschutes Brewery Portland Public House",
    brewery_type: "brewpub",
    street: "210 NW 11th Ave",
    city: "Portland",
    state: "Oregon",
    postal_code: "97209",
    phone: "5032964906",
    website_url: "https://www.deschutesbrewery.com",
    latitude: 45.5241000,
    longitude: -122.6817000,
    neighborhood: neighborhoods[:pearl_district],
    hours: "Sun-Thu 11am-10pm, Fri-Sat 11am-11pm",
    food: "Full kitchen",
    outdoor_seating: true,
    dog_friendly: false,
    kid_friendly: true,
    wifi: true
  },
  {
    open_brewery_db_id: "10-barrel-brewing-portland",
    name: "10 Barrel Brewing",
    brewery_type: "brewpub",
    street: "1411 NW Flanders St",
    city: "Portland",
    state: "Oregon",
    postal_code: "97209",
    phone: "5032241700",
    website_url: "https://www.10barrel.com",
    latitude: 45.5270000,
    longitude: -122.6856000,
    neighborhood: neighborhoods[:pearl_district],
    hours: "Sun-Thu 11am-10pm, Fri-Sat 11am-11pm",
    food: "Full kitchen",
    outdoor_seating: true,
    dog_friendly: false,
    kid_friendly: true,
    wifi: true
  },
  {
    open_brewery_db_id: "rogue-ales-public-house-pearl-portland",
    name: "Rogue Ales Public House",
    brewery_type: "brewpub",
    street: "1339 NW Flanders St",
    city: "Portland",
    state: "Oregon",
    postal_code: "97209",
    phone: "5032225910",
    website_url: "https://www.rogue.com",
    latitude: 45.5268000,
    longitude: -122.6843000,
    neighborhood: neighborhoods[:pearl_district],
    hours: "Sun-Thu 11am-9pm, Fri-Sat 11am-10pm",
    food: "Full kitchen",
    outdoor_seating: false,
    dog_friendly: false,
    kid_friendly: true,
    wifi: true
  },
  {
    open_brewery_db_id: "fathead-brewery-portland",
    name: "Fat Head's Brewery",
    brewery_type: "brewpub",
    street: "131 NW 13th Ave",
    city: "Portland",
    state: "Oregon",
    postal_code: "97209",
    phone: "5039521950",
    website_url: "https://www.fatheads.com",
    latitude: 45.5234000,
    longitude: -122.6833000,
    neighborhood: neighborhoods[:pearl_district],
    hours: "Sun-Thu 11am-10pm, Fri-Sat 11am-11pm",
    happy_hour: "Mon-Fri 3-6pm",
    food: "Full kitchen",
    outdoor_seating: true,
    dog_friendly: false,
    kid_friendly: true,
    wifi: true,
    events: "Live music Fridays"
  },
  {
    open_brewery_db_id: "von-ebert-brewing-pearl-portland",
    name: "Von Ebert Brewing",
    brewery_type: "brewpub",
    street: "131 NW 13th Ave",
    city: "Portland",
    state: "Oregon",
    postal_code: "97209",
    phone: "9712299610",
    website_url: "https://www.vonebertbrewing.com",
    latitude: 45.5236000,
    longitude: -122.6836000,
    neighborhood: neighborhoods[:pearl_district],
    hours: "Mon-Thu 11:30am-9pm, Fri-Sat 11:30am-10pm, Sun 11:30am-9pm",
    food: "Full kitchen",
    outdoor_seating: true,
    dog_friendly: false,
    kid_friendly: true,
    wifi: true
  }
]

breweries.each do |attrs|
  brewery = Brewery.find_or_initialize_by(open_brewery_db_id: attrs[:open_brewery_db_id])
  brewery.update!(attrs)
end

puts "Seeded #{Brewery.count} breweries across #{Neighborhood.count} neighborhoods."

%w[breweries:fetch_photos breweries:fetch_maps neighborhoods:fetch_maps].each do |task|
  Rake::Task[task].invoke
rescue SystemExit
  puts "Skipping #{task} (credentials not configured)."
end
