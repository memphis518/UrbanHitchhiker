class Trip < ActiveRecord::Base

  acts_as_commentable

  has_one :origin, -> { where :location_type => :origin }, :class_name => 'Location' , :dependent => :destroy
  has_one :destination, -> { where :location_type => :destination }, :class_name => 'Location', :dependent => :destroy

  has_many :bookings

  accepts_nested_attributes_for :origin, :allow_destroy => true
  accepts_nested_attributes_for :destination, :allow_destroy => true

  belongs_to :user

  validates_presence_of :name, :destination, :origin, :start_datetime, :transportation, :total_seats, :description

  validate :start_datetime_is_future, :on => :create

  def seats_remaining
     return total_seats - bookings.count
  end

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

end
