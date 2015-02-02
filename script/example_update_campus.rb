#!/usr/bin/env/rails r

ress = Restaurant.all
cnt = 1
ress.each do |res|
  campus = Campus.find_by_name_eng(res.campus)
  if campus == nil
    campus = Campus.new
    campus.name_eng = res.campus
  end

  campus.restaurants.push(res)
  campus.save

  puts cnt.to_s + campus.restaurants.count.to_s
  puts campus.name_eng + "    " + res.name 

  cnt = cnt+1
end
