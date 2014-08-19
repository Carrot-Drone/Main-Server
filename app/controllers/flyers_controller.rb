class FlyersController < ApplicationController
  before_action :set_flyer, only: [:show, :edit, :update, :destroy]

  # GET /flyers
  # GET /flyers.json
  def index
    if params[:restaurant_id] != nil
      @restaurant = Restaurant.find_by_id(params[:restaurant_id])
      @flyers = @restaurant.flyers
    else
      @flyers = Array.new
    end
  end

  # GET /flyers/1
  # GET /flyers/1.json
  def show
  end

  # GET /flyers/new
  def new
    @flyer = Flyer.new
  end

  # GET /flyers/1/edit
  def edit
  end

  # POST /flyers
  # POST /flyers.json
  def create
    @flyer = Flyer.new(flyer_params)

    respond_to do |format|
      if @flyer.save
        @restaurant = Restaurant.find_by_id(flyer_params[:restaurant_id])
        @restaurant.save # Update updated_time of restaurant
        format.html { redirect_to controller: 'flyers', action: 'index', restaurant_id: flyer_params[:restaurant_id], notice: 'Flyer was successfully created.' }
        format.json { render action: 'show', status: :created, location: @flyer }
      else
        format.html { render action: 'new' }
        format.json { render json: @flyer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /flyers/1
  # PATCH/PUT /flyers/1.json
  def update
    respond_to do |format|
      if @flyer.update(flyer_params)
        @restaurant = Restaurant.find_by_id(flyer_params[:restaurant_id])
        @restaurant.save  # Update updated_time of restaurant

        format.html { redirect_to controller: 'flyers', action: 'index', restaurant_id: @flyer.restaurant_id, notice: 'Flyer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @flyer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /flyers/1
  # DELETE /flyers/1.json
  def destroy
    restaurant_id = @flyer.restaurant_id
    @flyer.destroy

    @restaurant = Restaurant.find_by_id(restaurant_id)
    @restaurant.save  # Update updated_time of restaurant

    respond_to do |format|
      format.html { redirect_to controller: 'flyers', action: 'index', restaurant_id: restaurant_id, notice: 'Flyer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_flyer
      @flyer = Flyer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def flyer_params
      params.require(:flyer).permit(:flyer, :restaurant_id)
    end
end
