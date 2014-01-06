require 'spec_helper'

describe "user_potentials/new" do
  before(:each) do
    assign(:user_potential, stub_model(UserPotential,
      :email => "MyString"
    ).as_new_record)
  end

  it "renders new user_potential form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", user_potentials_path, "post" do
      assert_select "input#user_potential_email[name=?]", "user_potential[email]"
    end
  end
end
