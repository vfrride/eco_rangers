class RangerIconsController < ApplicationController
  before_action :set_ranger_icon, only: [:show, :edit, :update, :destroy]

  # GET /ranger_icons
  # GET /ranger_icons.json
  def index
    @ranger_icons = RangerIcon.all
  end

  # GET /ranger_icons/1
  # GET /ranger_icons/1.json
  def show
  end

  # GET /ranger_icons/new
  def new
    @ranger_icon = RangerIcon.new
  end

  # GET /ranger_icons/1/edit
  def edit
  end

  # POST /ranger_icons
  # POST /ranger_icons.json
  def create
    @ranger_icon = RangerIcon.new(ranger_icon_params)

    respond_to do |format|
      if @ranger_icon.save
        format.html { redirect_to @ranger_icon, notice: 'Ranger icon was successfully created.' }
        format.json { render :show, status: :created, location: @ranger_icon }
      else
        format.html { render :new }
        format.json { render json: @ranger_icon.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ranger_icons/1
  # PATCH/PUT /ranger_icons/1.json
  def update
    respond_to do |format|
      if @ranger_icon.update(ranger_icon_params)
        format.html { redirect_to @ranger_icon, notice: 'Ranger icon was successfully updated.' }
        format.json { render :show, status: :ok, location: @ranger_icon }
      else
        format.html { render :edit }
        format.json { render json: @ranger_icon.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ranger_icons/1
  # DELETE /ranger_icons/1.json
  def destroy
    @ranger_icon.destroy
    respond_to do |format|
      format.html { redirect_to ranger_icons_url, notice: 'Ranger icon was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ranger_icon
      @ranger_icon = RangerIcon.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ranger_icon_params
      params.require(:ranger_icon).permit(:image_url)
    end
end
