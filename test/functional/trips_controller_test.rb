require 'test_helper'

class TripsControllerTest < ActionController::TestCase
  self.use_instantiated_fixtures  = true
  
  setup do
    session[:user_id] = 1000001
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:trips)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create_trip
    assert_difference('Trip.count') do
      post :create, :trip => {:origin => "Austin,TX", :destination => "Dallas,TX", :trip_type => "Driver", :name => "Austin To Dallas", :comments => "Test Trip",
                              :start_date => Date.today, :start_time =>  "12:08:55", :transportation => "Car"}
    end

    assert_response :success
  end

  def test_bad_create
     post :create, :trip => {:destination => "Dallas,TX", :trip_type => "Driver", :name => "Austin To Dallas", :comments => "Test Trip",
                  :start_date => Date.today, :start_time =>  "12:08:55", :transportation => "Car"}
     assert_response :success
     assert_template "trips/new"
     post :create, :trip => {:origin => "Austin,TX", :trip_type => "Driver", :name => "Austin To Dallas", :comments => "Test Trip",
                  :start_date => Date.today , :start_time =>  "12:08:55", :transportation => "Car"}
     assert_response :success
     assert_template "trips/new"
     post :create, :trip => {:origin => "Austin,TX", :destination => "Dallas,TX", :name => "Austin To Dallas", :comments => "Test Trip",
                  :start_date => Date.today , :start_time =>  "12:08:55", :transportation => "Car"}
     assert_response :success
     assert_template "trips/new"
     post :create, :trip => {:origin => "Austin,TX", :destination => "Dallas,TX", :trip_type => "Driver", :comments => "Test Trip",
                  :start_date => Date.today , :start_time =>  "12:08:55", :transportation => "Car"}
     assert_response :success
     assert_template "trips/new"
     post :create, :trip => {:origin => "Austin,TX", :destination => "Dallas,TX", :trip_type => "Driver", :name => "Austin To Dallas", :comments => "Test Trip",
                  :start_date => Date.today , :transportation => "Car"}
     assert_response :success
     assert_template "trips/new"
     post :create, :trip => {:origin => "Austin,TX", :destination => "Dallas,TX", :trip_type => "Driver", :name => "Austin To Dallas", :comments => "Test Trip",
                  :start_date => Date.today , :start_time =>  "12:08:55"}
     assert_response :success
     assert_template "trips/new"
     post :create, :trip => {:origin => "Austin,TX", :destination => "Dallas,TX", :trip_type => "Driver", :name => "Austin To Dallas", :comments => "Test Trip",
                  :start_time =>  Date.today , :transportation => "Car"}
     assert_response :success
     assert_template "trips/new"
    
  end  

  def test_not_logged_in    
     session[:user_id] = nil    
     post :create, :trip => {:origin => "Austin,TX", :destination => "Dallas,TX", :trip_type => "Driver", :name => "Austin To Dallas", :comments => "Test Trip",
                  :start_date => Date.today , :start_time =>  "12:08:55", :transportation => "Car"} 
     assert_redirected_to :controller=>'users', :action=>'login'
  end

  def test_show_trip
    get :show, :id => @mellisa[:id]
    assert_response :success
  end

  def test_edit_trip
    get :edit, :id => @mellisa[:id]
    assert_response :success
  end

  def test_update_trip
    put :update, :id => @mellisa[:id], :trip => @mellisa
    assert_response :success
  end

  def test_destroy_trip
    assert_difference('Trip.count', -1) do
      delete :destroy, :id => @mellisa[:id]
    end

    assert_redirected_to trips_path
  end

  def test_map_trip
    get :map, :id => @mellisa[:id]
    assert_response :success
    assert_template "trips/map"
  end

  def test_trip_matches
    bounds = {
            'sw' => { 'lat' => 26.267337852178457,
                      'lng' => -124.72298531249999},
            'ne' => { 'lat' => 40.841681270139176,
                      'lng' => -95.10384468749999}
    }
    boundsJSON = ActiveSupport::JSON.encode(bounds);
    post :matches, :id => @mellisa[:id], :bounds => boundsJSON 
    assert_response :success
    matches = ActiveSupport::JSON.decode(@response.body)
    found_match   = false;
    found_nomatch = false;
    found_mellisa = false;
    matches.each { |match|
        if(match['trip']['id'] == @mellisaMatch[:id])
            found_match = true
        elsif(match['trip']['id'] == @mellisaNoMatch[:id])
            found_nomatch = true
        elsif(match['trip']['id'] == @mellisa[:id])
            found_mellisa = true
        end
    }

    assert found_match
    assert !found_nomatch
    assert !found_mellisa
  end

end
