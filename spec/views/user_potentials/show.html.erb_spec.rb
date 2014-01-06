require 'spec_helper'

describe "user_potentials/show" do
  before(:each) do
    @user_potential = assign(:user_potential, stub_model(UserPotential,
      :email => "Email"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    expect(rendered).to match(/Email/)
  end
end
