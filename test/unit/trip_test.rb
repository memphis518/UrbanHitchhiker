require 'test_helper'

class TripTest < ActiveSupport::TestCase
  
  self.use_instantiated_fixtures  = true

  def test_required

    t = Trip.new( :destination => "Dallas,TX", :trip_type => "Driver", :name => "Austin To Dallas", :comments => "Test Trip",
                  :start_date => Date.today, :start_time =>  "12:08:55", :transportation => "Car", :user_id => @bob[:id]);
    assert !t.save     
    assert t.errors.any?
    
    t = Trip.new( :origin => "Austin,TX", :trip_type => "Driver", :name => "Austin To Dallas", :comments => "Test Trip",
                  :start_date => Date.today , :start_time =>  "12:08:55", :transportation => "Car", :user_id => @bob[:id]);
    assert !t.save     
    assert t.errors.any?
    
    t = Trip.new( :origin => "Austin,TX", :destination => "Dallas,TX", :name => "Austin To Dallas", :comments => "Test Trip",
                  :start_date => Date.today , :start_time =>  "12:08:55", :transportation => "Car", :user_id => @bob[:id]);
    assert !t.save     
    assert t.errors.any?
    
    t = Trip.new( :origin => "Austin,TX", :destination => "Dallas,TX", :trip_type => "Driver", :comments => "Test Trip",
                  :start_date => Date.today , :start_time =>  "12:08:55", :transportation => "Car", :user_id => @bob[:id]);
    assert !t.save     
    assert t.errors.any?
    
    t = Trip.new( :origin => "Austin,TX", :destination => "Dallas,TX", :trip_type => "Driver", :name => "Austin To Dallas", :comments => "Test Trip",
                  :start_date => Date.today , :transportation => "Car", :user_id => @bob[:id]);
    assert !t.save     
    assert t.errors.any?
    
    t = Trip.new( :origin => "Austin,TX", :destination => "Dallas,TX", :trip_type => "Driver", :name => "Austin To Dallas", :comments => "Test Trip",
                  :start_date => Date.today , :start_time =>  "12:08:55", :user_id => @bob[:id]);
    assert !t.save     
    assert t.errors.any?
    
    t = Trip.new( :origin => "Austin,TX", :destination => "Dallas,TX", :trip_type => "Driver", :name => "Austin To Dallas", :comments => "Test Trip",
                  :start_date => Date.today , :start_time =>  "12:08:55", :transportation => "Car" );
    assert !t.save     
    assert t.errors.any?
    
    t = Trip.new( :origin => "Austin,TX", :destination => "Dallas,TX", :trip_type => "Driver", :name => "Austin To Dallas", :comments => "Test Trip",
                  :start_time =>  Date.today , :transportation => "Car", :user_id => @bob[:id]);
    assert !t.save     
    assert t.errors.any?
    
    t = Trip.new( :origin => "Austin,TX", :destination => "Dallas,TX", :trip_type => "Driver", :name => "Austin To Dallas", :comments => "Test Trip",
                  :start_date => Date.today, :start_time =>  "12:08:55", :transportation => "Car", :user_id => @bob[:id]);
    assert t.save     
    assert !t.errors.any?
    
  end
  
  def test_valid_addresses
     t = Trip.new( :origin => "Austin,TX", :destination => "asdfasdf", :trip_type => "Driver", :name => "Austin To Dallas", :comments => "Test Trip",
                  :start_date => Date.today, :start_time =>  "12:08:55", :transportation => "Car", :user_id => @bob[:id]);
    assert !t.save     
    assert t.errors.any?

     t = Trip.new( :origin => "asdfasdfasdf", :destination => "Dallas,TX", :trip_type => "Driver", :name => "Austin To Dallas", :comments => "Test Trip",
                  :start_date => Date.today, :start_time =>  "12:08:55", :transportation => "Car", :user_id => @bob[:id]);
    assert !t.save     
    assert t.errors.any?

     t = Trip.new( :origin => "Austin,TX", :destination => "Dallas,TX", :trip_type => "Driver", :name => "Austin To Dallas", :comments => "Test Trip",
                  :start_date => Date.today, :start_time =>  "12:08:55", :transportation => "Car", :user_id => @bob[:id]);
    assert t.save     
    assert !t.errors.any?
  end

  def test_past_date
     t = Trip.new( :origin => "Austin,TX", :destination => "Dallas,TX", :trip_type => "Driver", :name => "Austin To Dallas", :comments => "Test Trip",
                    :start_date => 1929-10-11, :start_time =>  "12:08:55", :transportation => "Car", :user_id => @bob[:id]);
     assert !t.save     
     assert t.errors.any?
  end
  
  def test_protected_attributes
    #check attributes are protected
    t = Trip.new( :id => 987654, :origin => "Austin,TX", :destination => "Dallas,TX", :trip_type => "Driver", :name => "Austin To Dallas", :comments => "Test Trip",
                  :start_date => Date.today , :start_time =>  "12:08:55", :transportation => "Car", :user_id => @bob[:id]);
    assert t.save
    assert_not_equal 999999, t.id

    t.update_attributes(:id=>999999, :origin => "Dallas,TX")
    assert t.save
    assert_not_equal 999999, t.id
    assert_equal "Dallas,TX", t.origin
  end

  def test_getmatchesbybounds
       bounds = {
            'sw' => { 'lat' => 26.267337852178457,
                      'lng' => -124.72298531249999},
            'ne' => { 'lat' => 40.841681270139176,
                      'lng' => -95.10384468749999}
       }
       matches = Trip.getMatchesByBounds(bounds, @mellisa[:user_id]);
       assert (matches.include? @mellisaMatch)
       assert (!matches.include? @mellisaNoMatch)
       assert (!matches.include? @mellisa)
  end
 
end
