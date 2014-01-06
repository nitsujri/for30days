class UserPotentialsController < ApplicationController
  before_action :set_user_potential, only: [:show, :edit, :update, :destroy]

  # GET /user_potentials
  # GET /user_potentials.json
  def index
    @user_potentials = UserPotential.all
  end

  # GET /user_potentials/1
  # GET /user_potentials/1.json
  def show
  end

  # GET /user_potentials/new
  def new
    @user_potential = UserPotential.new
  end

  # GET /user_potentials/1/edit
  def edit
  end

  # POST /user_potentials
  # POST /user_potentials.json
  def create
    @user_potential = UserPotential.new(user_potential_params)

    respond_to do |format|
      if @user_potential.save
        format.html { redirect_to :back, notice: 'Thank you for registering. We will notify you once we launch.' }
        format.json { render action: 'show', status: :created, location: @user_potential }
      else
        format.html { render action: 'new' }
        format.json { render json: @user_potential.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_potentials/1
  # PATCH/PUT /user_potentials/1.json
  def update
    respond_to do |format|
      if @user_potential.update(user_potential_params)
        format.html { redirect_to @user_potential, notice: 'User potential was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user_potential.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_potentials/1
  # DELETE /user_potentials/1.json
  def destroy
    @user_potential.destroy
    respond_to do |format|
      format.html { redirect_to user_potentials_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_potential
      @user_potential = UserPotential.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_potential_params
      params.require(:user_potential).permit(:email)
    end
end
