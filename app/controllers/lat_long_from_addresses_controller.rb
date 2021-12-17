class LatLongFromAddressesController < ApplicationController
  before_action :set_lat_long_from_address, only: %i[ show edit update destroy ]

  # GET /lat_long_from_addresses or /lat_long_from_addresses.json
  def index
    @lat_long_from_addresses = LatLongFromAddress.all
  end

  # GET /lat_long_from_addresses/1 or /lat_long_from_addresses/1.json
  def show
  end

  # GET /lat_long_from_addresses/new
  def new
    @lat_long_from_address = LatLongFromAddress.new
  end

  # GET /lat_long_from_addresses/1/edit
  def edit
  end

  # POST /lat_long_from_addresses or /lat_long_from_addresses.json
  def create
    @lat_long_from_address = LatLongFromAddress.new(lat_long_from_address_params)

    respond_to do |format|
      if @lat_long_from_address.save
        format.html { redirect_to @lat_long_from_address, notice: "Lat long from address was successfully created." }
        format.json { render :show, status: :created, location: @lat_long_from_address }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @lat_long_from_address.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lat_long_from_addresses/1 or /lat_long_from_addresses/1.json
  def update
    respond_to do |format|
      if @lat_long_from_address.update(lat_long_from_address_params)
        format.html { redirect_to @lat_long_from_address, notice: "Lat long from address was successfully updated." }
        format.json { render :show, status: :ok, location: @lat_long_from_address }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @lat_long_from_address.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lat_long_from_addresses/1 or /lat_long_from_addresses/1.json
  def destroy
    @lat_long_from_address.destroy
    respond_to do |format|
      format.html { redirect_to lat_long_from_addresses_url, notice: "Lat long from address was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lat_long_from_address
      @lat_long_from_address = LatLongFromAddress.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def lat_long_from_address_params
      params.require(:lat_long_from_address).permit(:address, :city, :state, :zip, :lat, :long, :previously_looked_up, :json_resp, :display_address)
    end
end
