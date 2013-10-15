require 'spec_helper'

describe 'Trip' do
    it 'create a trip' do

       FactoryGirl.build( :trip ).should be_valid

    end

    it 'validates start date is in the future' do

       FactoryGirl.build( :trip, :start_datetime => Time.now - 100).should_not be_valid

    end

end
