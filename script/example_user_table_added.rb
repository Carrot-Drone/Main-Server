Device.find_each do |d|
  if d.user == nil
    a = User.new
    a.devices.push(d)
    a.save
  end
end

UsersRestaurant.find_each do |ur|
  ur.destroy
end

cnt = 0
CallLog.find_each do |c|
  cnt += 1
  puts cnt
  if c.device_id != nil and c.restaurant_id != nil
    device = Device.find(c.device_id)
    user = device.user
    restaurant = Restaurant.where("id = ?", c.restaurant_id)
    if restaurant.count == 0 
      next
    else
      restaurant = restaurant[0]
    end
    unless user.restaurants.include? restaurant
      users_restaurant = UsersRestaurant.new
      users_restaurant.user_id = user.id
      users_restaurant.restaurant_id = restaurant.id
      users_restaurant.number_of_calls_for_system = 0
      users_restaurant.save
    end
    users_restaurant = UsersRestaurant.where("user_id = ? AND restaurant_id = ?", user.id, restaurant.id)
    if users_restaurant != nil
      users_restaurant = users_restaurant[0]
    end
    
    users_restaurant.number_of_calls_for_system += 1
    users_restaurant.save
  end
end
