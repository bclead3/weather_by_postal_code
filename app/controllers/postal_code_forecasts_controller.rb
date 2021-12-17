class PostalCodeForecastsController < ApplicationController
  before_action :set_postal_code_forecast, only: %i[ show edit update destroy ]

  # GET /postal_code_forecasts or /postal_code_forecasts.json
  def index
    @postal_code_forecasts = PostalCodeForecast.all
  end

  # GET /postal_code_forecasts/1 or /postal_code_forecasts/1.json
  def show
  end

  # GET /postal_code_forecasts/new
  def new
    @postal_code_forecast = PostalCodeForecast.new
  end

  # GET /postal_code_forecasts/1/edit
  def edit
  end

  # POST /postal_code_forecasts or /postal_code_forecasts.json
  def create
    @postal_code_forecast = PostalCodeForecast.new(postal_code_forecast_params)

    respond_to do |format|
      if @postal_code_forecast.save
        format.html { redirect_to @postal_code_forecast, notice: "Postal code forecast was successfully created." }
        format.json { render :show, status: :created, location: @postal_code_forecast }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @postal_code_forecast.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /postal_code_forecasts/1 or /postal_code_forecasts/1.json
  def update
    respond_to do |format|
      if @postal_code_forecast.update(postal_code_forecast_params)
        format.html { redirect_to @postal_code_forecast, notice: "Postal code forecast was successfully updated." }
        format.json { render :show, status: :ok, location: @postal_code_forecast }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @postal_code_forecast.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /postal_code_forecasts/1 or /postal_code_forecasts/1.json
  def destroy
    @postal_code_forecast.destroy
    respond_to do |format|
      format.html { redirect_to postal_code_forecasts_url, notice: "Postal code forecast was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_postal_code_forecast
      @postal_code_forecast = PostalCodeForecast.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def postal_code_forecast_params
      params.require(:postal_code_forecast).permit(:postal_code, :time_of_last_request)
    end
end
