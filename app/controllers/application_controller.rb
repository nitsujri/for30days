class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  before_action :load_graph_data

  private

  def load_graph_data
    if user_signed_in?
      @graph = Koala::Facebook::API.new(current_user.fb_access_token)
    end
  end
end
