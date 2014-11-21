class ProgressesController < ApplicationController
  include Devise::Controllers::Helpers

  before_action :set_progress, only: [:show, :edit, :update, :destroy]

  # GET /progresses
  # GET /progresses.json
  def index
    @progresses = Progress.all
  end

  # GET /progresses/1
  # GET /progresses/1.json
  def show
  end

  # GET /progresses/new
  def new
    @progress = Progress.new
  end

  # GET /progresses/1/edit
  def edit
  end

  # POST /progresses
  # POST /progresses.json
  def create
    @progress = Progress.new(progress_params)
    @progress.user = current_user
    @challenge = Challenge.find(progress_params[:challenge_id])
    @progress.participation = @challenge.participations.find_by(:user_id => current_user.id)
    respond_to do |format|
      if @progress.save
        @progress.create_activity :create, owner: current_user
        format.html { redirect_to @challenge, notice: 'Progress was successfully created.' }
        format.json { render :show, status: :created, location: @progress }
      else
        format.html { render :new }
        format.json { render json: @progress.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /progresses/1
  # PATCH/PUT /progresses/1.json
  def update
    respond_to do |format|
      if @progress.update(progress_params)
        @challenge = Challenge.find(progress_params[:challenge_id])
        format.html { redirect_to @challenge, notice: 'Progress was successfully updated.' }
        format.json { render :show, status: :ok, location: @progress }
      else
        format.html { render :edit }
        format.json { render json: @progress.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /progresses/1
  # DELETE /progresses/1.json
  def destroy
    @progress.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Progress was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_progress
      @progress = Progress.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def progress_params
      params.require(:progress).permit(:gain, :challenge_id)
    end
end
