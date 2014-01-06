require "spec_helper"

describe UserPotentialsController do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/user_potentials").to route_to("user_potentials#index")
    end

    it "routes to #new" do
      expect(:get => "/user_potentials/new").to route_to("user_potentials#new")
    end

    it "routes to #show" do
      expect(:get => "/user_potentials/1").to route_to("user_potentials#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/user_potentials/1/edit").to route_to("user_potentials#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/user_potentials").to route_to("user_potentials#create")
    end

    it "routes to #update" do
      expect(:put => "/user_potentials/1").to route_to("user_potentials#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/user_potentials/1").to route_to("user_potentials#destroy", :id => "1")
    end

  end
end
