# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
  ["park_ranger_hat.png", "wizard_hat.png", "red_baseball_hat.png"].each do |i|
    ri = RangerIcon.find_or_initialize_by(image_url: i)
    ri.save
  end

  rangers = []

  [ {email: "jpcutler@gmail.com", password: "password12345", ranger_icon_id: 1},
    {email: "velikovlukas@gmail.com", password: "password12345", ranger_icon_id: 2},
    {email: "wenny.miao@gmail.com", password: "password12345", ranger_icon_id: 3} ].each do |r|
      unless Ranger.where(email: r[:email]).count > 0
        ranger = Ranger.new(r)
        ranger.save
        rangers.push(ranger)
      end
  end

    [{"name"=>"Bus Stop", "description"=>"A place to get on/off the bus", "img_url"=>"bus_icon.png", "status"=>true},
      {"name"=>"Car Charger", "description"=>"Car Charging Station", "img_url"=>"charging.png", "status"=>true},
      {"name"=>"Recycling Bin", "description"=>"A place to put Recycling", "img_url"=>"recycle.png", "status"=>true},
      {"name"=>"Trash Can", "description"=>"A place to put non-recyclables", "img_url"=>"trash_can.png", "status"=>true}].each do |pt|
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
      place_type_id = [1, 3, 4].sample
      ranger = rangers.sample
      place = Place.find_or_initialize_by({
        name: loc["name"],
        address1: loc["name"],
        country: "USA",
        lat: loc["geometry"]["location"]["lat"],
        lng: loc["geometry"]["location"]["lng"],
        place_type_id: place_type_id
      })
      puts "JEFF #{ranger}"
      if place.save
        marker = Marker.find_or_initialize_by({
          lat: place.lat,
          lng: place.lng,
          place_type_id: place.place_type_id,
          ranger_id: ranger.id,
          place_id: place
        })
        marker.save
        puts place_type_id
      end
    end
