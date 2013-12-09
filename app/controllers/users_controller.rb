class UsersController < ApplicationController
  before_filter :authenticate_user!, only: [:edit]
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
    
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @user.update(task_params)
        format.html { redirect_to :back, notice: 'Task was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:user).permit(:time_zone)
    end
end
