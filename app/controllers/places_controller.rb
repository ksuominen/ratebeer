require 'json'
class PlacesController < ApplicationController
  before_action :set_place, only: [:show]

  def index
  end

  def show
  end

  def search
    @places = BeermappingApi.places_in(params[:city])
    @weather = WeatherstackApi.get_weather_in(params[:city])
    if @places.empty?
      flash.now[:notice] = "No locations in #{params[:city]}"
      render :index, status: 418
    else
      render :index, status: 418
    end
  end

  def set_place
    @place_id = params[:id]
    @place = BeermappingApi.get_place(@place_id)
  end
end
