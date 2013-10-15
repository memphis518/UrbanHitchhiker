class Location < ActiveRecord::Base
  attr_accessible :address, :latitude, :longitude, :location_type

  geocoded_by :address

  before_validation :geocode

  validates_presence_of :address
  validate :geocoding_was_found

  def geocoding_was_found
    errors.add(:address, 'is not valid') if latitude.nil? || longitude.nil?
  end

end
