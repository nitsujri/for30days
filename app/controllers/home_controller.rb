class HomeController < ApplicationController

  def index
    if user_signed_in?
      signed_in_home 
    else
      @task = Task.new
      @autotype_list = [
        "Run 5 miles",
        "Say thank you",
        "Tell someone I love them",
        "Learn French",
        "Write a blog post",
        "Write a short story",
      ]

      @ex_users = User.includes(:tasks).order("RAND()").limit(3)

    end
  end


  private

    def signed_in_home
      Time.use_zone(current_user.time_zone) do
        @current_task = Task.where(user_id: current_user.id)
                          .where("DATE(start_date) <= ?", Date.today)
                          .where("DATE(start_date) >= ?", Date.today - 30.days).first
      end

      if @current_task.present?
        if @current_task.marked_today?
          
          @current_task_log = @current_task.todays_log
          @journal          = Journal.new

        end
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
