require 'spec_helper'

describe Location do

  it 'creates a valid location with long and lat'  do

    location = FactoryGirl.create :location

    location.longitude.should_not eq nil
    location.latitude.should_not eq nil

  end

  it 'fails to create a non valid location' do

    location = FactoryGirl.build(:location, address: 'This will fail')

    location.should_not be_valid
    location.should have(1).error_on(:address)

  end

end
