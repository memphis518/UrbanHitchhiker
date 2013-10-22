class Location < ActiveRecord::Base
  attr_accessible :address, :latitude, :longitude, :location_type, :timezone

  geocoded_by :address

  before_validation :geocode

  after_validation :set_timezone_by_coordinates!, :if => 'timezone.blank?'

  validates_presence_of :address
  validate :geocoding_was_found

  def geocoding_was_found
    errors.add(:address, 'is not valid') if latitude.nil? || longitude.nil?
  end

  def timezone
    set_timezone_by_coordinates! if super.blank? && coordinates_present?
    super
  end

  def timezone=(value)
    super if value.present?
  end

  def coordinates_present?
    latitude.present? && longitude.present?
  end

  private

    def set_timezone_by_coordinates!
      write_attribute(:timezone, Timezone::Zone.new(latlon: [self.latitude, self.longitude]).zone) if coordinates_present?
      errors.add :timezone, 'was unable to be determined' if timezone.blank?
    end

end
