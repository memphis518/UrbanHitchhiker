require 'spec_helper'

describe "profiles/index" do
  before(:each) do
    assign(:profiles, [
      stub_model(Profile,
        :name => "Name",
        :description => "MyText",
        :transportation => "Transportation"
      ),
      stub_model(Profile,
        :name => "Name",
        :description => "MyText",
        :transportation => "Transportation"
      )
    ])
  end

  it "renders a list of profiles" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Transportation".to_s, :count => 2
  end
end
