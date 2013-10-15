require 'spec_helper'

describe "profiles/edit" do
  before(:each) do
    @profile = assign(:profile, stub_model(Profile,
      :name => "MyString",
      :description => "MyText",
      :transportation => "MyString"
    ))
  end

  it "renders the edit profile form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", profile_path(@profile), "post" do
      assert_select "input#profile_name[name=?]", "profile[name]"
      assert_select "textarea#profile_description[name=?]", "profile[description]"
      assert_select "input#profile_transportation[name=?]", "profile[transportation]"
    end
  end
end
