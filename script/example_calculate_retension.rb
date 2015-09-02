Restaurant.find_each do |res|
  # Brand New Restaurant
  if res.created_at > Time.now-60*60*24*30
    puts "#{res.name} : Brand New"
    #res.retention = -1
    res.retention = 0
    res.save
    next
  end

  # Total number of users less then 10
  total_number_of_users = UsersRestaurant.where("restaurant_id = ? AND number_of_calls_for_system != 0", res.id).count
  if total_number_of_users < 5 
    puts "#{res.name} : Less"
    #res.retention = -1
    res.retention = 0
    res.save
    next  
  end

  # Else
  number_of_retention_users = UsersRestaurant.where("restaurant_id = ? AND number_of_calls_for_system > 1", res.id).count
  number_of_recent_users = UsersRestaurant.where("restaurant_id = ? AND number_of_calls_for_system = 1", res.id).map {|ur| ur.user_id}
    .select {|id| CallLog.where("restaurant_id = ? AND user_id = ? AND created_at BETWEEN ? AND ?", 
  res.id, id, Time.now - 60*60*24*14, Time.now).count == 1 }.count

  res.retention = (number_of_retention_users.to_f + number_of_recent_users.to_f) / total_number_of_users.to_f
  puts "#{res.name} : #{total_number_of_users}명 #{res.retention * 100}% "
  res.save
end
