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
                              :time =>  "2011-06-19 12:08:55", :transportation => "Car", :user_id => @bob[:id]}
    end

    assert_redirected_to trip_path(assigns(:trip))
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
    assert_redirected_to trip_path(assigns(:trip))
  end

  def test_destroy_trip
    assert_difference('Trip.count', -1) do
      delete :destroy, :id => @mellisa[:id]
    end

    assert_redirected_to trips_path
  end
end
