class UsersController < ApplicationController

  before_filter :authenticate_user!, :only => [:edit]

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
    
  end
end
