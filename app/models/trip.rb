class Trip < ActiveRecord::Base

  acts_as_commentable

  attr_accessible :name, :start_datetime, :transportation, :destination_attributes, :origin_attributes, :total_seats, :seats_remaining, :compensation

  has_one :origin, :class_name => 'Location' , :dependent => :destroy, :conditions => { :location_type => :origin }
  has_one :destination, :class_name => 'Location', :dependent => :destroy, :conditions => { :location_type => :destination }

  has_many :bookings

  accepts_nested_attributes_for :origin, :allow_destroy => true
  accepts_nested_attributes_for :destination, :allow_destroy => true

  belongs_to :user

  validates_presence_of :name, :destination, :origin, :start_datetime, :transportation, :total_seats

  validate :start_datetime_is_future, :on => :create

  before_save :set_remaining_seats

  def start_datetime_is_future
    if start_datetime
      errors.add(:start_datetime, 'cannot be in the past') if (start_datetime < Time.now.utc)
    end
  end

  class << self
    def search_by_loc(coors = "Austin,TX")

       @locations = Location.near(coors, 300);
       return_trips = Array.new

       @locations.each do |loc|
         if(loc.location_type == 'origin')
          return_trips << Trip.find(loc.trip_id)
        end
       end
       return return_trips
    end
  end

  private
    def set_remaining_seats
      if(self.seats_remaining.nil?)
        self.seats_remaining = self.total_seats
      else
        self.seats_remaining = self.seats_remaining + (self.total_seats - self.total_seats_was)
      end
    end

end
