class MarkersController < ApplicationController
  before_action :set_marker, only: [:show, :edit, :update, :destroy]

  # GET /markers
  # GET /markers.json
  def index
    @markers = Marker.all
  end

  # GET /markers/1
  # GET /markers/1.json
  def show
  end

  # GET /markers/new
  def new
    @marker = Marker.new(lat: 42.732109, lng: -73.688966, ranger_id: 1)
  end

  # GET /markers/1/edit
  def edit
  end

  # POST /markers
  # POST /markers.json
  def create
    @marker = Marker.new(marker_params)

    place = Place.where(place_type_id: @marker.place_type_id)
                 .where("lat IS NOT NULL AND lng IS NOT NULL")
                 .closest(origin: [@marker.lat, @marker.lng])
                 .first

    should_create_place = true

    unless place.blank?
      puts "closest place #{place.name}"
      distance = place.distance_to(@marker)

      if distance < 0.1
        puts "it's a match!"
        @marker.place = place
        should_create_place = false
      end
    end

    if should_create_place
      puts "creating place"
      res = Geokit::Geocoders::GoogleGeocoder.reverse_geocode "#{@marker.lat},#{@marker.lng}"
      place = Place.new(name: res.full_address,
                        lat: @marker.lat,
                        lng: @marker.lng,
                        city: res.city,
                        state_code: res.state,
                        address1: res.street_address,
                        zip: res.zip,
                        place_type_id: @marker.place_type_id
                        )
      if place.save
        puts "saved place"
        @marker.place = place
      end
    end

    respond_to do |format|
      if @marker.save
        format.html { redirect_to @marker, notice: 'Marker was successfully created.' }
        format.json { render :show, status: :created, location: @marker }
      else
        format.html { render :new }
        format.json { render json: @marker.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /markers/1
  # PATCH/PUT /markers/1.json
  def update
    respond_to do |format|
      if @marker.update(marker_params)
        format.html { redirect_to @marker, notice: 'Marker was successfully updated.' }
        format.json { render :show, status: :ok, location: @marker }
      else
        format.html { render :edit }
        format.json { render json: @marker.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /markers/1
  # DELETE /markers/1.json
  def destroy
    @marker.destroy
    respond_to do |format|
      format.html { redirect_to markers_url, notice: 'Marker was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_marker
      @marker = Marker.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def marker_params
      params.require(:marker).permit(:lat, :lng, :place_type_id, :ranger_id)
    end
end
