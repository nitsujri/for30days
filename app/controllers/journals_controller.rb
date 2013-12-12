class JournalsController < ApplicationController
  before_action :set_journal, only: [:show, :edit, :update, :destroy]

  # GET /journals
  # GET /journals.json
  def index
    @journals = Journal.all
  end

  # GET /journals/1
  # GET /journals/1.json
  def show
  end

  # GET /journals/new
  def new
    @journal = Journal.new
  end

  # GET /journals/1/edit
  def edit
  end

  # POST /journals
  # POST /journals.json
  def create
    @journal         = Journal.new(journal_params)
    @journal.user_id = current_user.id

    if params[:task_log_id].present?
      @journal.journable = TaskLog.find(params[:task_log_id])
    elsif params[:taks_id].present?
      @journal.journable = Task.find(params[:task_id])
    end

    respond_to do |format|
      if @journal.save
        format.html { redirect_to :back, notice: 'Journal was successfully created.' }
        format.json { render action: 'show', status: :created, location: @journal }
      else
        format.html { redirect_to :back, alert: "Sorry, Journal could not be created." }
        format.json { render json: @journal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /journals/1
  # PATCH/PUT /journals/1.json
  def update
    respond_to do |format|
      if @journal.update(journal_params)
        format.html { redirect_to @journal, notice: 'Journal was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @journal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /journals/1
  # DELETE /journals/1.json
  def destroy
    @journal.destroy
    respond_to do |format|
      format.html { redirect_to journals_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_journal
      @journal = Journal.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def journal_params
      params.require(:journal).permit(:text)
      # params.require(:task).permit(:name, :user_id, :start_date)
    end
end
