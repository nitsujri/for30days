class HomeController < ApplicationController

  def index
    signed_in_home if user_signed_in?
  end


  private

    def signed_in_home
      Time.use_zone(current_user.time_zone) do
        @current_task = Task.where(user_id: current_user.id)
                          .where("DATE(start_date) <= ?", Date.today)
                          .where("DATE(start_date) >= ?", Date.today - 30.days).first
      end

      if @current_task.present?
        @journal = Journal.new
      else
        @inactive_tasks = Task.where(status: "inactive")

        if @inactive_tasks.blank?
          #if there are no tasks, create one
          @new_task = Task.new
        end

        #if there are tasks, let's start an inactive one

        #grab all "inactive tasks"

      end

      render "logged_in"    
    end
end
