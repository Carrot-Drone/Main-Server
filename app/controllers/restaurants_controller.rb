class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]
  skip_before_filter  :verify_authenticity_token

  def checkForUpdate
    restaurant_id = params[:restaurant_id]
    updated_at = params[:updated_at]

    @restaurant = Restaurant.find_by_id(restaurant_id)
    if @restaurant == nil
      @restaurant = Restaurant.select{|r| r.phone_number == params[:phone_number] and r.campus == params[:campus]}.first
    end

    if @restaurant.updated_at.to_s == Time.parse(updated_at).to_s
      render nothing: true, status: :no_content 
    else
      #render json: @restaurant, :include => :menus
      render json: @restaurant, :methods => [:flyers_url], :include => :menus
    end
  end

  def checkForResInCategory
    @restaurants = Restaurant.select {|r| r.category == params[:category] and r.campus == params[:campus]}
    render json: @restaurants, :only => [:id, :name, :phone_number, :has_coupon, :has_flyer]
  end

  def new_menu
    restaurant = Restaurant.all.select {|r| r.campus == "Gwanak" and r.phone_number == params[:phoneNumber].delete(' ')}.first

    restaurant.category = params[:categories]
    restaurant.openingHours = params[:openingHours].to_f
    restaurant.closingHours = params[:closingHours].to_f
    restaurant.has_flyer = params[:has_flyer]
    restaurant.has_coupon = params[:has_coupon]
    restaurant.save

    if restaurant.menus.count == 0
      menus = params[:menu]
      menus.each do |section, menus|
        menus.each do |menu|
          m = Menu.new
          m.section = section
          m.name = menu[0]
          m.price = menu[1].to_i
          m.save
          restaurant.menus.push(m)
        end
      end
    end
    render :nothing => true
  end

  def campus
    @campuses = Array.new
    Restaurant.all.each do |res|
      @campuses.push(res.campus)
    end
    @campuses.uniq!
    @campuses.sort!
  end

  # GET /restaurants
  # GET /restaurants.json
  def index
    @restaurants = Restaurant.all
    if params[:campus] != nil
      @restaurants = Restaurant.select {|r| r.campus == params[:campus]}
    end
  end

  # GET /restaurants/1
  # GET /restaurants/1.json
  def show
  end

  # GET /restaurants/new
  def new
    @restaurant = Restaurant.new
  end

  # GET /restaurants/1/edit
  def edit
  end

  # POST /restaurants
  # POST /restaurants.json
  def create
    @restaurant = Restaurant.new(restaurant_params)

    respond_to do |format|
      if @restaurant.save
        format.html { redirect_to @restaurant, notice: 'Restaurant was successfully created.' }
        format.json { render action: 'show', status: :created, location: @restaurant }
      else
        format.html { render action: 'new' }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /restaurants/1
  # PATCH/PUT /restaurants/1.json
  def update
    respond_to do |format|
      if @restaurant.update(restaurant_params)
        format.html { redirect_to @restaurant, notice: 'Restaurant was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /restaurants/1
  # DELETE /restaurants/1.json
  def destroy
    @restaurant.destroy
    respond_to do |format|
      format.html { redirect_to restaurants_url }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def restaurant_params
    params.require(:restaurant).permit(:name, :phone_number, :campus, :category, :openingHours, :closingHours, :has_flyer, :has_coupon, :flyer)
  end
end
