class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:edit, :update]
  skip_before_filter  :verify_authenticity_token

  def show
    restaurant_id = params[:restaurant_id] 
    updated_at = params[:updated_at]
    uuid = params[:uuid]

    if updated_at == nil or updated_at == ""
      updated_at = Time.new(2000).to_s
    end

    restaurant = Restaurant.find(restaurant_id)
    restaurant.uuid = uuid
    if restaurant.updated_at.to_s <= updated_at
      render nothing: true, status: :no_content 
    else
      @json = restaurant.to_json(
        :methods => [:flyers_url, :number_of_my_calls, :total_number_of_calls, :my_preference, :retention, :total_number_of_good, :total_number_of_bad, :has_flyer], 
        :include => {
          :menus =>{
            :except => [:id, :created_at, :updated_at],
            :include => :submenus
          }
        }
      )
      render json: @json 
    end
  end

  def is_good
    restaurant_id = params[:restaurant_id]
    uuid = params[:uuid]

    if restaurant_id == nil or uuid == nil
      render nothing: true, status: :bad_request
    end
    device = Device.find_by_uuid(uuid)
    user = device.user
    ur = UsersRestaurant.where("user_id = ? AND restaurant_id = ?", user.id, restaurant_id)

    if ur == nil || ur.first == nil
      ur = UsersRestaurant.new
      ur.user = user
      ur.restaurant_id = restaurant_id
      ur.number_of_calls_for_user = 0
      ur.number_of_calls_for_system = 0
    else
      ur = ur.first
    end
    ur.preference = 1
    ur.save
    render nothing: true, status: :ok
  end

  def is_bad
    restaurant_id = params[:restaurant_id]
    uuid = params[:uuid]

    if restaurant_id == nil or uuid == nil
      render nothing: true, status: :bad_request
    end
    device = Device.find_by_uuid(uuid)
    user = device.user
    ur = UsersRestaurant.where("user_id = ? AND restaurant_id = ?", user.id, restaurant_id)

    if ur == nil
      ur = UsersRestaurant.new
      ur.user = user
      ur.restaurant_id = restaurant_id
      ur.number_of_calls_for_user = 0
      ur.number_of_calls_for_system = 0
    else
      ur = ur.first
    end
    ur.preference = -1
    ur.save
    render nothing: true, status: :ok
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def restaurant_params
    params.require(:restaurant).permit(:name, :phone_number, :campus, :category, :openingHours, :closingHours, :has_coupon, :flyer, :is_new, :coupon_string)
  end


  public
  # Deprecated methods

  def allRestaurants
    campus = Campus.find_by_name_eng(params[:campus])
    uuid = params[:uuid]

    categories = campus.categories
    restaurants = categories.map do |c| 
      c.restaurants.each do |res|
        res.category = c.title
        res.uuid = uuid
      end.flatten
    end

    @json = restaurants.to_json(
      :methods => [:flyers_url, :number_of_my_calls, :category, :total_number_of_calls, :my_preference, :has_flyer], 
      :include => {:menus => {:include => :submenus}}
    )

    render json: @json 
  end
  
  def checkForResInCategory
    campus = Campus.find_by_name_eng(params[:campus])
    categories = campus.categories.select {|cat| cat.title == params[:category]}
    restaurants = categories.map do |c| 
      c.restaurants.each do |res|
        res.category = c.title
      end
    end.flatten

    @json = restaurants.to_json(
      :only => [:id, :name, :phone_number, :has_coupon, :is_new, :retention, :updated_at],
      :methods => [:category, :has_flyer])
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
      @json = @restaurant.to_json(:methods => [:flyers_url, :has_flyer], :include => {:menus => {:include => :submenus}})
      render json: @json 
    end
  end
  def new_menu
    restaurant = Restaurant.all.select {|r| r.campus == "Gwanak" and r.phone_number == params[:phoneNumber].delete(' ')}.first

    restaurant.category = params[:categories]
    restaurant.openingHours = params[:openingHours].to_f
    restaurant.closingHours = params[:closingHours].to_f
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
end
