# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
    [{"name"=>"Bus Stop", "description"=>"A place to get on/off the bus", "img_url"=>"bus_icon.png", "status"=>false},
      {"name"=>"Car Charger", "description"=>"Car Charging Station", "img_url"=>"charging.png", "status"=>false},
      {"name"=>"Recycling Bin", "description"=>"A place to put Recycling", "img_url"=>"recycle.jpg", "status"=>false}].each do |pt|
      place_type = PlaceType.find_or_initialize_by(pt)
      place_type.save
    end


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
      place_type_id = rand.round == 0 ? 1 : 3
      place = Place.find_or_initialize_by({
        name: loc["name"],
        address1: loc["name"],
        country: "USA",
        lat: loc["geometry"]["location"]["lat"],
        lng: loc["geometry"]["location"]["lng"],
        place_type_id: place_type_id
      }
      )
      if place.save
          puts place_type_id
      end
    end
