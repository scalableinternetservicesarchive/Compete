class ChallengesController < ApplicationController
  include Devise::Controllers::Helpers

  before_filter :require_premisson, only: [:edit, :destroy]
  before_action :set_challenge, only: [:show, :edit, :update, :destroy]

  #caches_action :index, :show

  # GET /challenges
  # GET /challenges.json
  def index
    #@challenge = Challenge.all_cached
    #@stats = Rails.cache.stats.first.last
    page = params[:page].blank? ? 1 : params[:page]
    @result = Rails.cache.read(page)
    if @result.blank?
      flash[:notice] = "Added to cache"
      @result = Challenge.paginate(:page => page, :per_page => 3).all
      Rails.cache.write(page, @result)
    else
      flash[:notice] = "In cache"
    end
    @challenge = Challenge.all

  end

  # GET /challenges/1
  # GET /challenges/1.json
  def show

    def sportname
      sports[sport]
    end

  end

  # GET /challenges/new
  def new
    @challenge = Challenge.new
  end


  # GET /challenges/1/edit
  def edit
  end

  # POST /challenges
  # POST /challenges.json
  def create
    @challenge = Challenge.new(challenge_params)
    @challenge.start = Date::civil(params[:challenge]['start(1i)'].to_i,
                                   params[:challenge]['start(2i)'].to_i,
                                   params[:challenge]['start(3i)'].to_i)
    @challenge.stop = Date::civil(params[:challenge]['stop(1i)'].to_i,
                                  params[:challenge]['stop(2i)'].to_i,
                                  params[:challenge]['stop(3i)'].to_i)
    @challenge.user = current_user
    respond_to do |format|
      if @challenge.save
        @challenge.create_activity :create, owner: current_user
        format.html { redirect_to @challenge, notice: 'Challenge was successfully created.' }
        format.json { render :show, status: :created, location: @challenge }
      else
        format.html { render :new }
        format.json { render json: @challenge.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /challenges/1
  # PATCH/PUT /challenges/1.json
  def update
    #expire_action :action => :show
    @challenge.start = Date::civil(params[:challenge]['start(1i)'].to_i,
                                   params[:challenge]['start(2i)'].to_i,
                                   params[:challenge]['start(3i)'].to_i)
    @challenge.stop = Date::civil(params[:challenge]['stop(1i)'].to_i,
                                  params[:challenge]['stop(2i)'].to_i,
                                  params[:challenge]['stop(3i)'].to_i)
    @challenge.distance = params[:challenge]['distance']

    respond_to do |format|
      if @challenge.update(challenge_params)
        format.html { redirect_to @challenge, notice: 'Challenge was successfully updated.' }
        format.json { render :show, status: :ok, location: @challenge }
      else
        format.html { render :edit }
        format.json { render json: @challenge.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /challenges/1
  # DELETE /challenges/1.json
  def destroy
    #expire_action :action => :show
    @challenge.destroy
    respond_to do |format|
      format.html { redirect_to challenges_url, notice: 'Challenge was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_challenge
      @challenge = Challenge.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def challenge_params
      params.require(:challenge).permit(:name, :description, :sport, :distance, :category)
    end

  def require_premisson
    if current_user != Challenge.find(params[:id]).user
      redirect_to challenges_path
    end
  end


end
