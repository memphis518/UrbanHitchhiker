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
  validate  :api_validate
  belongs_to :user
  
  attr_protected :id

  # When saving origin, it needs to find the lng and lat of the address
  def origin=(originAddress)
    write_attribute(:origin, originAddress)
    setAttrLatLng("origin", originAddress)
  end

  # When saving destination, it needs to find the lng and lat of the address
  def destination=(destinationAddress)
    write_attribute(:destination, destinationAddress)
    setAttrLatLng("destination", destinationAddress)
  end

  def setAttrLatLng(field, address)
    begin
      if(!@api_error)
        @api_error = {}
      end
      result = getGeoCodeData(address)
      if(result["status"] == 'OK')
        write_attribute(field + "_longitude" , result["results"][0]["geometry"]["location"]["lng"].to_f)
        write_attribute(field + "_latitude", result["results"][0]["geometry"]["location"]["lat"].to_f)
      elsif(result["status"] == 'ZERO_RESULTS')
        @api_error[field] = "is an invalid address"
      else
        @api_error[field] = "had an error validating your address. Please try again."
      end
    rescue Exception => e
      logger.debug(e.message)
      logger.debug(e.backtrace.inspect)
      @api_error[field] = "had an error validating your address. Please try again."
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
    if(@api_error)
      if(@api_error["origin"])
        self.errors.add("origin", @api_error["origin"])
      end

      if(@api_error["destination"])
        self.errors.add("destination", @api_error["destination"])
      end
    end
  end

end
