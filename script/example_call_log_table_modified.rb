callLogs = CallLog.all
cnt = 0
callLogs.each do |c|
  cnt += 1
  puts cnt
  # campus 
  unless c.campus == nil
    campus = Campus.find_by_name_eng(c.campus)
    if campus != nil
      c.campus_id = campus.id
    end
  end

  # user
  unless c.device == nil
    device = c.device
    c.user = device.user
  end

  # category
  unless c.restaurant == nil
    c.category = c.restaurant.categories.first
  end
  c.save
end

