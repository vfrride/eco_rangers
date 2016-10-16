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

    results = @local_places.order(:place_type_id)

    grouped_results = {}

    current_group = results[0].place_type_id

    results.each do |result|
      gs = "pt#{result.place_type_id}"
      if (!grouped_results[gs])
        grouped_results[gs] = []
      end

      grouped_results[gs].push(result.get_json)
    end

    render json: grouped_results
  end


  def session_loc
    [session[:geo_location]["lat"], session[:geo_location]["lng"]]
    [42.7311462,-73.690161]
  end
end
