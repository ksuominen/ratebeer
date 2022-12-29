class PlacesController < ApplicationController
  def index
  end

  def search
    api_key = "c924d5f59e963d7de3050f8d2fb34220"
    url = "http://beermapping.com/webservice/loccity/#{api_key}/"
    
    response = HTTParty.get "#{url}#{params[:city]}"
    places_from_api = response.parsed_response["bmp_locations"]["location"]
    
    if places_from_api.is_a?(Hash) && places_from_api['id'].nil?
      redirect_to places_path, notice: "No places in #{params[:city]}"
    else
      places_from_api = [places_from_api] if places_from_api.is_a?(Hash)
      @places = places_from_api.map do | location |
        Place.new(location)
      end
      render :index, status: 418
    end
  end
end