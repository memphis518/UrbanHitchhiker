require 'test_helper'

class TripTest < ActiveSupport::TestCase
  
  self.use_instantiated_fixtures  = true

  def test_required

    t = Trip.new( :destination => "Dallas,TX", :trip_type => "Driver", :name => "Austin To Dallas", :comments => "Test Trip",
                  :time =>  "2011-06-19 12:08:55", :transportation => "Car", :user_id => @bob[:id]);
    assert !t.save     
    assert t.errors.any?
    
    t = Trip.new( :origin => "Austin,TX", :trip_type => "Driver", :name => "Austin To Dallas", :comments => "Test Trip",
                  :time =>  "2011-06-19 12:08:55", :transportation => "Car", :user_id => @bob[:id]);
    assert !t.save     
    assert t.errors.any?
    
    t = Trip.new( :origin => "Austin,TX", :destination => "Dallas,TX", :name => "Austin To Dallas", :comments => "Test Trip",
                  :time =>  "2011-06-19 12:08:55", :transportation => "Car", :user_id => @bob[:id]);
    assert !t.save     
    assert t.errors.any?
    
    t = Trip.new( :origin => "Austin,TX", :destination => "Dallas,TX", :trip_type => "Driver", :comments => "Test Trip",
                  :time =>  "2011-06-19 12:08:55", :transportation => "Car", :user_id => @bob[:id]);
    assert !t.save     
    assert t.errors.any?
    
    t = Trip.new( :origin => "Austin,TX", :destination => "Dallas,TX", :trip_type => "Driver", :name => "Austin To Dallas", :comments => "Test Trip",
                  :transportation => "Car", :user_id => @bob[:id]);
    assert !t.save     
    assert t.errors.any?
    
    t = Trip.new( :origin => "Austin,TX", :destination => "Dallas,TX", :trip_type => "Driver", :name => "Austin To Dallas", :comments => "Test Trip",
                  :time =>  "2011-06-19 12:08:55", :user_id => @bob[:id]);
    assert !t.save     
    assert t.errors.any?
    
    t = Trip.new( :origin => "Austin,TX", :destination => "Dallas,TX", :trip_type => "Driver", :name => "Austin To Dallas", :comments => "Test Trip",
                  :time =>  "2011-06-19 12:08:55", :transportation => "Car" );
    assert !t.save     
    assert t.errors.any?
    
    t = Trip.new( :origin => "Austin,TX", :destination => "Dallas,TX", :trip_type => "Driver", :name => "Austin To Dallas", :comments => "Test Trip",
                  :time =>  "2011-06-19 12:08:55", :transportation => "Car", :user_id => @bob[:id]);
    assert t.save     
    assert !t.errors.any?
    
  end
  
  def test_protected_attributes
    #check attributes are protected
    t = Trip.new( :id => 987654, :origin => "Austin,TX", :destination => "Dallas,TX", :trip_type => "Driver", :name => "Austin To Dallas", :comments => "Test Trip",
                  :time =>  "2011-06-19 12:08:55", :transportation => "Car", :user_id => @bob[:id]);
    assert t.save
    assert_not_equal 999999, t.id

    t.update_attributes(:id=>999999, :origin => "Dallas,TX")
    assert t.save
    assert_not_equal 999999, t.id
    assert_equal "Dallas,TX", t.origin
  end
  
end
