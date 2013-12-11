class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  # GET /tasks
  # GET /tasks.json
  def index
    if params[:user_id]
      load_new_task
      @tasks = Task.where(user_id: params[:user_id])
      
    else
      @tasks = Task.all
    end
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    load_new_task
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id

    respond_to do |format|
      if @task.save
        format.html { redirect_to :back, notice: 'Task was successfully created.' }
        format.json { render action: 'show', status: :created, location: @task }
      else
        format.html { render action: 'new' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to user_tasks_url }
      format.json { head :no_content }
    end
  end

  # Other things =====================================================
  def start
    @task = Task.find(params[:task_id])

    respond_to do |format|
      unless @task.has_conflicts?
        @task.update_attributes(status: "active")

        msg = "Awesome, let's go tackle - #{@task.name}"

        format.html { redirect_to :back, notice: msg}
        format.json { render json: { :task => @task, message: msg } }
      else

        msg = "Sorry there's already an active task! Let's finish that one first."

        format.html { redirect_to :back, alert: msg}
        format.json { render json: { :task => @task, message: msg } }
      end
    end

  end

  # Daily Task Completion ============================================
  def completed
    @task = Task.find(params[:task_id])

    respond_to do |format|
      unless @task.marked_today?
        @tasklog = TaskLog.create( task_id: @task.id, user_id: current_user.id, status: "completed")

        msg = "#{@task.name} completed today, good job!"

        
        format.html { redirect_to :back, notice: msg}
        format.json { render json: { :task_log => @tasklog, message: msg } }
        
      else
        msg = "This you already marked this as completed today."

        #also need to be able to respond to 30+ days
        format.html { redirect_to :back, alert: msg}
        format.json { render json: { :message => msg, :status => "failed" } }
      end
    end

  end

  def missed

    respond_to do |format|
      unless @task.marked_today?
        @tasklog = TaskLog.create( task_id: @task.id, user_id: current_user.id, status: "missed")

        msg = "Sorry, you missed #{@task.name} today."

        
        format.html { redirect_to :back, notice: msg}
        format.json { render json: { :task_log => @tasklog, message: msg } }
        
      else
        msg = "This you already marked this as missed today."

        #also need to be able to respond to 30+ days
        format.html { redirect_to :back, alert: msg}
        format.json { render json: { :message => msg, :status => "failed" } }
      end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    def load_new_task
      @task = Task.new
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:name, :user_id, :start_date)
    end
end
