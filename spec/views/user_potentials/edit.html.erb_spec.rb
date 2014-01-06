require 'spec_helper'

describe "user_potentials/edit" do
  before(:each) do
    @user_potential = assign(:user_potential, stub_model(UserPotential,
      :email => "MyString"
    ))
  end

  it "renders the edit user_potential form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", user_potential_path(@user_potential), "post" do
      assert_select "input#user_potential_email[name=?]", "user_potential[email]"
    end
  end
end
