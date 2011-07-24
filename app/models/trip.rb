require 'net/http'
require 'json'

class Trip < ActiveRecord::Base
  
  validates :origin,        :presence => true
  validates :destination,   :presence => true
  validates :trip_type,     :presence => true
  validates :name,          :presence => true
  validates :start_date,          :presence => true
  validates :start_date,
            :date => {:after_or_equal_to => Proc.new { Date.today } }
  validates :start_time,          :presence => true
  validates :transportation,:presence => true
  validates :user_id,       :presence => true
  validate :api_validate
  belongs_to :user
  
  attr_protected :id

  # When saving origin, it needs to find the lng and lat of the address
  def origin=(originAddress)
    write_attribute(:origin, originAddress);
    begin
      result = getGeoCodeData(originAddress)
      if(result["status"] == 'OK')
        write_attribute(:origin_longitude , result["results"][0]["geometry"]["location"]["lng"].to_f)
        write_attribute(:origin_latitude , result["results"][0]["geometry"]["location"]["lat"].to_f)
      elsif(result["status"] == 'ZERO_RESULTS')
        @origin_api_error = "is an invalid address"
      else
        @origin_api_error = "had an error validating your address. Please try again."
      end
    rescue Exception => e
      logger.debug(e.message)
      logger.debug(e.backtrace.inspect)
      @origin_api_error = "had an error validating your address. Please try again."
    end
  end

  # When saving destination, it needs to find the lng and lat of the address
  def destination=(destinationAddress)
    write_attribute(:destination, destinationAddress);
    begin
      result = getGeoCodeData(destinationAddress)
      if(result["status"] == 'OK')
        write_attribute(:destination_longitude , result["results"][0]["geometry"]["location"]["lng"].to_f)
        write_attribute(:destination_latitude , result["results"][0]["geometry"]["location"]["lat"].to_f)
      elsif(result["status"] == 'ZERO_RESULTS')
        @destination_api_error = "is an invalid address"
      else
        @destination_api_error = "had an error validating your address. Please try again."
      end
    rescue Exception => e
      logger.debug(e.message)
      logger.debug(e.backtrace.inspect)
      @destination_api_error = "had an error validating your address. Please try again."
    end
  end

  # Calls Google Geocoder API
  def getGeoCodeData(address)
    url = 'http://maps.googleapis.com/maps/api/geocode/json?sensor=true&address=' + URI.encode(address)
    resp = Net::HTTP.get_response(URI.parse(url))
    data = resp.body
    logger.debug(data)
    result = JSON.parse(data)
    logger.debug(data)
    return result
  end

  # This takes any errors calling the Geocoder API to the normal validators
  def api_validate
    if(defined? @origin_api_error)
      self.errors.add("origin", @origin_api_error)
    end

    if(defined? @destination_api_error)
      self.errors.add("destination", @destination_api_error)
    end
  end

end
