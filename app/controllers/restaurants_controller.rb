class RestaurantsController < ApplicationController
  before_action :authenticate_admin!, :only => [:index, :show, :edit, :new]
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]

  skip_before_filter  :verify_authenticity_token

  def allRestaurants
    campus = Campus.find_by_name_eng(params[:campus])
    categories = campus.categories
    restaurants = categories.map {|c| c.restaurants }.flatten

    @json = restaurants.to_json(:methods => [:flyers_url], :include => :menus)

    category_titles = categories.map do |c| 
      titles = []
      c.restaurants.count.times do
        titles.push(c.title)
      end
      titles
    end
    category_titles.flatten!

    res_array = JSON.parse @json
    res_array.each_with_index do |val, index|
      val["category"] = category_titles[index]
    end

    @json = res_array.to_json
    render json: @json 
  end

  def checkForUpdate
    restaurant_id = params[:restaurant_id]
    updated_at = params[:updated_at]
    if updated_at == nil or updated_at == ""
      updated_at = "12:00"
    end

    @restaurant = Restaurant.find_by_id(restaurant_id)
    if @restaurant == nil
      @restaurant = Restaurant.select{|r| r.phone_number == params[:phone_number] and r.campus.name_eng == params[:campus]}.first
    end

    if @restaurant.updated_at.to_s == Time.parse(updated_at).to_s
      render nothing: true, status: :no_content 
    else
      #render json: @restaurant, :include => :menus
      render json: @restaurant, :methods => [:flyers_url], :include => :menus
    end
  end

  def checkForRestaurants
    #@restaurants = Restaurant.select {|r| r.campus == params[:campus]}
    campus = Campus.find_by_name_eng(params[:campus])
    categories = campus.categories
    restaurants = categories.map {|c| c.restaurants }.flatten

    @json = restaurants.to_json(:only => [:id, :name, :phone_number, :has_coupon, :has_flyer, :is_new, :updated_at])

    category_titles = categories.map do |c| 
      titles = []
      c.restaurants.count.times do
        titles.push(c.title)
      end
      titles
    end
    category_titles.flatten!
    
    res_array = JSON.parse @json
    res_array.each_with_index do |val, index|
      val["category"] = category_titles[index]
    end

    @json = res_array.to_json
    render json: @json 
  end
  
  def checkForResInCategory
    campus = Campus.find_by_name_eng(params[:campus])
    categories = campus.categories.select {|cat| cat.title == params[:category]}
    restaurants = categories.map {|c| c.restaurants }.flatten

    @json = restaurants.to_json(:only => [:id, :name, :phone_number, :has_coupon, :has_flyer, :is_new, :updated_at])

    category_titles = categories.map do |c| 
      titles = []
      c.restaurants.count.times do
        titles.push(c.title)
      end
      titles
    end
    category_titles.flatten!
    
    res_array = JSON.parse @json
    res_array.each_with_index do |val, index|
      val["category"] = category_titles[index]
    end
    render json: @json
  end

  def updateDevice
    if params[:uuid] == nil or params[:device] == nil or params[:campus] == nil
      render :nothing => true, :status => 400, :content_type => 'text/html'
    end

    @device = Device.find_by_uuid(params[:uuid])
    if @device == nil
      @device = Device.new
      @device.uuid = params[:uuid]
    end

    @device.device_type = params[:device]
    @device.campus = Campus.find_by_name_eng(params[:campus])
    @device.save

    render :nothing => true, :status => 200, :content_type => 'text/html'
  end

  # Deprecated methods
  def allDataGwanak
    @json = Restaurant.select{|r| r.campus == "Gwanak"}.to_json(:methods => [:flyers_url], :include => :menus)
    
    render json: @json
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
      menuss = params[:menu]
      menuss.each do |section, menus|
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

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def restaurant_params
    params.require(:restaurant).permit(:name, :phone_number, :campus, :category, :openingHours, :closingHours, :has_flyer, :has_coupon, :flyer, :is_new, :coupon_string)
  end

end
