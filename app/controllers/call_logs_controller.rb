class CallLogsController < ApplicationController
  skip_before_filter  :verify_authenticity_token
  def new
    campus_id = params[:campus_id]
    category_id = params[:category_id]
    restaurant_id = params[:restaurant_id]
    device_uuid = params[:uuid]
    number_of_calls_for_user = params[:number_of_calls]

    # deprecated params
    campus_eng = params[:campus]
    device_type ||= params[:device]
    phone_number = params[:phoneNumber]
    unless phone_number == nil
      phone_number = phone_number.delete(' ')
    end
    # deprecated params
    

    call_log = CallLog.new

    # set campus
    if campus_id == nil
      campus = Campus.find_by_name_eng(campus_eng)
      if campus != nil
        call_log.campus_id = campus.id
      end
    else
      call_log.campus_id = campus_id
    end 

    # set restaurant and category
    if restaurant_id == nil
      restaurants = Restaurant.select {|r| r.phone_number == phone_number}
      if campus_eng  != nil
        restaurants.select! {|r| r.categories.map{|c| c.campus.name_eng}.include? campus_eng}
        if restaurants.count > 0
          restaurant = restaurants[0]
          restaurant.call_logs.push(call_log)
          restaurant.save
        end 
      end
    else
      call_log.restaurant_id = restaurant_id
    end

    if category_id == nil
      call_log.category = call_log.restaurant.categories.first
    else
      call_log.category_id = category_id
    end

    # set device and user
    if not device_uuid == nil
      device = Device.find_by_uuid(device_uuid)
      if device == nil
        device = Device.new
        device.save
      end
      user = device.user
      if user == nil
        user = User.new
        user.devices.push(device)
        user.save
      end
      device.uuid = device_uuid
      device.device_type = device_type
      device.campus = call_log.campus

      call_log.device = device
      call_log.user = user
      device.save
      user.save
    end

    # set number_of_calls
    if number_of_calls_for_user != nil and call_log.user != nil and call_log.restaurant != nil
      usersRestaurants = UsersRestaurant.where("user_id = ? AND restaurant_id = ?", call_log.user_id, call_log.restaurant_id).first
      if usersRestaurants == nil
        usersRestaurants = UsersRestaurant.new
        usersRestaurants.user = call_log.user
        usersRestaurants.restaurant = call_log.restaurant
        usersRestaurants.number_of_calls_for_user = 0
        usersRestaurants.number_of_calls_for_system = 0
      end
      usersRestaurants.number_of_calls_for_user = number_of_calls_for_user
      usersRestaurants.number_of_calls_for_system += 1
      usersRestaurants.save
    end

    call_log.save

    render :nothing => true
  end
end
