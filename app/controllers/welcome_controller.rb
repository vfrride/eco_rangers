class WelcomeController < ApplicationController
  geocode_ip_address

  def index
    @title = "Eco Rangers"
    @local_places = Place.where("lat is not null AND lng IS NOT NULL").all #within(10000, origin: session_loc)
    @place_types = PlaceType.all
  end

  def locations
    dist = params[:distance] || 10
    loc = params[:loc] || session_loc
    @local_places = Place.includes(:place_type).where("lat IS NOT NULL AND lng IS NOT NULL")

    @local_places = @local_places.where(place_type_id: params[:place_type]) if (params[:place_type])

    @local_places = @local_places.within(dist, origin: loc)

    results = @local_places.map do |lp|
      {lat: lp.lat, lng: lp.lng, label: lp.label, place_type_id: lp.place_type_id}
    end

    render json: results
  end


  def session_loc
    [session[:geo_location]["lat"], session[:geo_location]["lng"]]
    [42.7311462,-73.690161]
  end
end
