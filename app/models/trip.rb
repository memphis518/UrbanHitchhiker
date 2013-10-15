class Trip < ActiveRecord::Base

  attr_accessible :name, :start_datetime, :transportation, :trip_type, :destination_attributes, :origin_attributes

  enum_attr :trip_type, %w(Hitchhiker Driver)

  has_one :origin, :class_name => 'Location' , :dependent => :destroy, :conditions => { :location_type => :origin }
  has_one :destination, :class_name => 'Location', :dependent => :destroy, :conditions => { :location_type => :destination }

  accepts_nested_attributes_for :origin, :allow_destroy => true
  accepts_nested_attributes_for :destination, :allow_destroy => true

  belongs_to :user

  validates_presence_of :name, :destination, :origin, :start_datetime, :transportation, :trip_type

  validate :start_datetime_is_future, :on => :create

  def start_datetime_is_future
    if start_datetime
      errors.add(:start_datetime, 'cannot be in the past') if (start_datetime < Time.now.utc)
    end
  end

end
