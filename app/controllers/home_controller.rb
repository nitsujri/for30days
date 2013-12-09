class HomeController < ApplicationController

  def index
    if user_signed_in?
      render "logged_in"
    end
  end
end
