class SpotsController < ApplicationController
  before_action :set_spot, only: %i[ show edit update destroy ]

  # GET /spots or /spots.json
  def index
    @user = User.find(current_user.id)
    # puts("**********")
    # puts(@user.points)
    @spots = Spot.limit(@user.points)
    @spots_list = []
    @spots.each do |spot|
      @spots_list += [[time_in_sec(spot.time2leave), spot.latitude, spot.longitude, spot.id]]
    end
  end

  # GET /spots/1 or /spots/1.json
  def show
    # @user = User.find(current_user.id)
  end

  # GET /spots/new
  def new
    @spot = Spot.new
  end

  # GET /spots/1/edit
  def edit
    puts(@spot.latitude)
    puts(@spot.user)
    if @spot.user!=current_user.id
      redirect_to spots_url, notice: "Yor are not authorized to edit this spot."
    end
  end

  # POST /spots or /spots.json
  def create
    @spot = Spot.new(spot_params)
    @spot.going = 0
    @spot.user = current_user.id
    respond_to do |format|
      if @spot.save
        format.html { redirect_to spot_url(@spot), notice: "Spot was successfully created." }
        format.json { render :show, status: :created, location: @spot }
        #add 1 point to user
        @user = User.find(current_user.id)
        @user.points = @user.points+1
        @user.save
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @spot.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /spots/1 or /spots/1.json
  def update
    respond_to do |format|
      if @spot.update(spot_params)
        format.html { redirect_to spot_url(@spot), notice: "Spot was successfully updated." }
        format.json { render :show, status: :ok, location: @spot }

      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @spot.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /spots/1 or /spots/1.json
  def destroy
    @spot.destroy

    respond_to do |format|
      format.html { redirect_to spots_url, notice: "Spot was successfully destroyed." }
      format.json { head :no_content }
    end
  end


  def add_going
    cur_id = session[:session_id]
    spot_id = params[:format]
    # spotValue = spot_id+cur_id
    spotValue = spot_id
    if session[:spots]==nil
      session[:spots]=Array.new
    end
    if session[:spots].include? spotValue
      redirect_to spots_url, notice: "You have already added it. "
    else
      session[:spots].push(spotValue)
      @spot = Spot.find(spot_id)
      @spot.going = @spot.going+1
      @spot.save
      redirect_to spots_url, notice: "You successfully add it to your going. "
      
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_spot
      @spot = Spot.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def spot_params
      params.require(:spot).permit(:time2leave, :latitude, :longitude)
    end

    # helper
    def time_in_sec(time2leave)
      inputTime = Time.new(time2leave.year, time2leave.month, time2leave.day, time2leave.hour, time2leave.min, time2leave.sec, "-05:00")
      return inputTime - Time.now.in_time_zone("Eastern Time (US & Canada)")
  end
end

