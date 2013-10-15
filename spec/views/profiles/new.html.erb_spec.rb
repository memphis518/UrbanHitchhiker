require 'spec_helper'

describe "profiles/new" do
  before(:each) do
    assign(:profile, stub_model(Profile,
      :name => "MyString",
      :description => "MyText",
      :transportation => "MyString"
    ).as_new_record)
  end

  it "renders new profile form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", profiles_path, "post" do
      assert_select "input#profile_name[name=?]", "profile[name]"
      assert_select "textarea#profile_description[name=?]", "profile[description]"
      assert_select "input#profile_transportation[name=?]", "profile[transportation]"
    end
  end
end
