require 'spec_helper'

describe "bookings/new" do
  before(:each) do
    assign(:booking, stub_model(Booking,
      :trip_id => 1,
      :user_id => 1
    ).as_new_record)
  end

  it "renders new booking form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", bookings_path, "post" do
      assert_select "input#booking_trip_id[name=?]", "booking[trip_id]"
      assert_select "input#booking_user_id[name=?]", "booking[user_id]"
    end
  end
end
