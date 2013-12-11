class HomeController < ApplicationController

  def index
    if user_signed_in?
      Time.use_zone(current_user.time_zone) do
        @current_task = Task.where(user_id: current_user.id)
                          .where("DATE(start_date) <= ?", Date.today)
                          .where("DATE(start_date) >= ?", Date.today - 30.days).first
      end

      unless @current_task.present?
        #grab all "inactive tasks"
      end

      render "logged_in"
    end
  end
end
