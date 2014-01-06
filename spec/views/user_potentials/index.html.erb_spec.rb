require 'spec_helper'

describe "user_potentials/index" do
  before(:each) do
    assign(:user_potentials, [
      stub_model(UserPotential,
        :email => "Email"
      ),
      stub_model(UserPotential,
        :email => "Email"
      )
    ])
  end

  it "renders a list of user_potentials" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Email".to_s, :count => 2
  end
end
