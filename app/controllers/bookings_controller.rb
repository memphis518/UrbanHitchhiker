class BookingsController < ApplicationController

  load_and_authorize_resource
  before_filter :authenticate_user!

  # POST /bookings
  # POST /bookings.json
  def create
    @trip = Trip.find(params[:trip_id])
    @booking = Booking.new
    @booking.trip = @trip
    @booking.user = current_user

    respond_to do |format|
      if @booking.save
        format.html { redirect_to @trip, notice: 'Booking was successfully created.' }
        format.json { render json: @trip, status: :created, location: @trip }
      else
        format.html { redirect_to @trip }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookings/1
  # DELETE /bookings/1.json
  def destroy

    @trip = Trip.find(params[:trip_id])
    @booking = Booking.find(params[:id])
    @booking.destroy

    respond_to do |format|
      format.html { redirect_to @trip, notice: 'Your booking has been cancelled.' }
      format.json { head :no_content }
    end
  end
end
