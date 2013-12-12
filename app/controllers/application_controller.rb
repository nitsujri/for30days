class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def after_sign_in_path_for(user)
    check_homepage_task_entry
    super  
  end


  private
    def check_homepage_task_entry
      
      return unless session[:task].present?

      #If someone started typing earlier let's carry that through
    
      params[:task] = session[:task]
      session[:task] = nil #zero it out so we don't get stuck

      if current_user.active_tasks.count.zero?
        status = "active"
      else
        status = "inactive"
      end

      @task         = Task.new(params.require(:task).permit(:name))
      @task.status  = status
      @task.user_id = current_user.id
      @task.save
    
    end

end
