class HomeController < ApplicationController

  before_filter :authenticate_user!

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
      @trips = TripDecorator.decorate_collection(Trip.search_by_loc(@coors))


  end
end
