devices = Device.all
devices.each do |d|
  if d.user == nil
    a = User.new
    a.devices.push(d)
    a.save
  end
end

=begin
users_restaurants = UsersRestaurant.all
users_restaurants.each do |ur|
  ur.destroy
end
=end

=begin IF you want to init UsersRestaurant with callLogs
call_logs = CallLog.all
restaurants = Restaurant.all

cnt = 0
call_logs.each do |c|
  cnt += 1
  puts cnt
  if c.device_id != nil and c.restaurant_id != nil
    device = Device.find(c.device_id)
    user = device.user
    restaurant = restaurants.select {|res| res.id == c.restaurant_id.to_i}
    if restaurant.count == 0 
      next
    else
      restaurant = restaurant[0]
    end
    unless user.restaurants.include? restaurant
      users_restaurant = UsersRestaurant.new
      users_restaurant.user_id = user.id
      users_restaurant.restaurant_id = restaurant.id
      users_restaurant.number_of_calls = 0
      users_restaurant.save
    end
    users_restaurant = UsersRestaurant.where("user_id = ? AND restaurant_id = ?", user.id, restaurant.id)
    if users_restaurant != nil
      users_restaurant = users_restaurant[0]
    end
    
    users_restaurant.number_of_calls += 1
    users_restaurant.save
  end
end
=end
