class HomeController < ApplicationController
  def index
      @coors
      @trips
      if(params[:location])
        @coors = Geocoder.coordinates(params[:location])
      else
        @coors = request.location.coordinates
        if(@coors[0] == 0.0)
          @coors = Geocoder.coordinates('Austin,TX')
        end
      end
      @trips = Trip.search_by_loc(@coors)

  end
end
