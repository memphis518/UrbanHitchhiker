class TripsController < ApplicationController
  
  before_filter :login_required
  layout 'application', :only => [:index] 
  
  # GET /trips
  # GET /trips.xml
  def index
    @trips = Trip.find_all_by_user_id(session[:user_id])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @trips }
    end
  end

  # GET /trips/1
  # GET /trips/1.xml
  def show
    @trip = Trip.find(params[:id])
    if(@trip.user_id == session[:user_id])
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @trip }
      end
    else
      render :template => 'users/loginfailed'
    end
    
  end

  # GET /trips/new
  # GET /trips/new.xml
  def new
    @trip = Trip.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @trip }
    end
  end

  # GET /trips/1/edit
  def edit
    @trip = Trip.find(params[:id])
  end

  # POST /trips
  # POST /trips.xml
  def create
    @user = User.find(session[:user_id])
    @trip = @user.trips.create(params[:trip])
    
    respond_to do |format|
      if @trip.save
        format.html { render(:partial => 'save_successful', :layout => false) }
        format.xml  { render :xml => @trip, :status => :created, :location => @trip }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @trip.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /trips/1
  # PUT /trips/1.xml
  def update
    @trip = Trip.find(params[:id])
    if(@trip.user_id == session[:user_id])
      respond_to do |format|
        if @trip.update_attributes(params[:trip])
          format.html { render(:partial => 'save_successful', :layout => false) }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @trip.errors, :status => :unprocessable_entity }
        end
      end
    else
      render :template => 'users/loginfailed'
    end
  end

  # DELETE /trips/1
  # DELETE /trips/1.xml
  def destroy
    @trip = Trip.find(params[:id])
    if(@trip.user_id == session[:user_id])
      @trip.destroy

      respond_to do |format|
        format.html { redirect_to(trips_url) }
        format.xml  { head :ok }
      end
    else
      render :template => 'users/loginfailed'
    end
  end

  # GET /trips/1/map
  def map
     @trip = Trip.find(params[:id])
     if(@trip.user_id == session[:user_id])
         render :template => 'trips/map'      
     end 
  end  

end
