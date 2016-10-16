# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
    file = File.read('db/fixtures/charging.json')
    data_hash = JSON.parse(file)
    data_hash.each_with_index do |point, index|
      loc = point["AddressInfo"]
      place = Place.find_or_initialize_by({
        name: loc["Title"],
        address1: loc["AddressLine1"],
        city: loc["Town"],
        state_code: loc["StateOrProvince"],
        zip: loc["Postcode"],
        country: "USA",
        lat: loc["Latitude"],
        lng: loc["Longitude"],
        place_type_id: 2
      }
      )
      if place.save
        puts "index: #{index}"
      end
    end

    file = File.read('db/fixtures/busstops.json')
    data_hash = JSON.parse(file)
    data_hash["results"].each_with_index do |point, index|
      loc = point
      place = Place.find_or_initialize_by({
        name: loc["name"],
        address1: loc["name"],
        country: "USA",
        lat: loc["geometry"]["location"]["lat"],
        lng: loc["geometry"]["location"]["lng"],
        place_type_id: 1
      }
      )
      if place.save
        puts "index: #{index}"
      end
    end
