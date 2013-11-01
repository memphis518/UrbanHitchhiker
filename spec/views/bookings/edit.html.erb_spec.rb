require 'spec_helper'

describe "bookings/edit" do
  before(:each) do
    @booking = assign(:booking, stub_model(Booking,
      :trip_id => 1,
      :user_id => 1
    ))
  end

  it "renders the edit booking form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", booking_path(@booking), "post" do
      assert_select "input#booking_trip_id[name=?]", "booking[trip_id]"
      assert_select "input#booking_user_id[name=?]", "booking[user_id]"
    end
  end
end
