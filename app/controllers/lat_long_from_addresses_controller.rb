require 'assets/web/web_station_request'
require 'assets/web/web_forecast_request'

class LatLongFromAddressesController < ApplicationController
  before_action :set_lat_long_from_address, only: %i[ show edit update destroy ]

  # GET /lat_long_from_addresses or /lat_long_from_addresses.json
  def index
    @lat_long_from_addresses = LatLongFromAddress.all
  end

  # GET /lat_long_from_addresses/1 or /lat_long_from_addresses/1.json
  def show
    @postal_code_forecast = @lat_long_from_address.populate
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
    address = lat_long_from_address_params[:address]
    city = lat_long_from_address_params[:city]

    @lat_long_from_address = LatLongFromAddress.find_or_create_by(address: address, city: city)
    @postal_code_forecast = @lat_long_from_address.populate
    is_too_early = @postal_code_forecast.is_below_cache_expiration
    lat = @lat_long_from_address.lat
    long = @lat_long_from_address.long

    station_obj = Assets::Web::WebStationRequest.new
    station_hash = station_obj.request_weather_station(lat, long)

    forecast_obj = Assets::Web::WebForecastRequest.new
    nugget_hash = forecast_obj.parse_nuggets_from_json_resp(station_hash)
    # pp nugget_hash
    forecast_obj.update_postal_code_forecast(nugget_hash, @postal_code_forecast)

    forecast_obj.create_forecast_periods(nugget_hash[:forecast_url], @postal_code_forecast.postal_code)
    forecast_obj.create_forecast_periods(nugget_hash[:hourly_url], @postal_code_forecast.postal_code)

    cache_hash = forecast_obj.create_cache(@postal_code_forecast.postal_code)
    # pp cache_hash

    forecast_obj.update_postal_code_forecast_two(@postal_code_forecast, cache_hash)

    respond_to do |format|
      if @lat_long_from_address.save
        if is_too_early
          format.html { redirect_to @lat_long_from_address, postal_code_forecast: @postal_code_forecast, notice: "Retrieving weather history from cache." }
          format.json { render :show, status: :created, location: @lat_long_from_address }
        else
          format.html { redirect_to @lat_long_from_address, postal_code_forecast: @postal_code_forecast, notice: "Lat long from address was successfully created." }
          format.json { render :show, status: :created, location: @lat_long_from_address }
        end

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
