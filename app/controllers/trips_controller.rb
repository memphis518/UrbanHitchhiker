class TripsController < ApplicationController

  load_and_authorize_resource

  before_filter :authenticate_user!

  # GET /trips
  # GET /trips.json
  def index
    @trips = TripDecorator.decorate_collection(current_user.trips.load)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @trips }
    end
  end

  # GET /trips/1
  # GET /trips/1.json
  def show
    @trip = TripDecorator.decorate(Trip.find(params[:id]))
    @comment = Comment.new
    @all_comments = CommentDecorator.decorate_collection(@trip.comments.recent.all)
    @all_bookings = BookingDecorator.decorate_collection(@trip.bookings.all.to_a)
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @trip }
    end
  end

  # GET /trips/new
  # GET /trips/new.json
  def new
    @trip = Trip.new
    @trip.build_origin
    @trip.build_destination
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @trip }
    end
  end

  # GET /trips/1/edit
  def edit
    @trip = Trip.find(params[:id])
  end

  # POST /trips
  # POST /trips.json
  def create

    @trip = Trip.new(trip_parameters)
    @trip.user = current_user

    respond_to do |format|
      if @trip.save
        format.html { redirect_to @trip, notice: 'Trip was successfully created.' }
        format.json { render json: @trip, status: :created, location: @trip }
      else
        format.html { render action: 'new' }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /trips/1
  # PUT /trips/1.json
  def update
    @trip = Trip.find(params[:id])

    respond_to do |format|
      if @trip.update_attributes(trip_parameters)
        format.html { redirect_to @trip, notice: 'Trip was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trips/1
  # DELETE /trips/1.json
  def destroy
    @trip = Trip.find(params[:id])
    @trip.destroy

    respond_to do |format|
      format.html { redirect_to trips_url }
      format.json { head :no_content }
    end
  end

  private
    def trip_parameters
      params.require(:trip).permit(:name, :start_datetime, :transportation,
                                   :total_seats, :compensation, :description,
                                    destination_attributes: [:address],
                                    origin_attributes: [:address])
    end
end
