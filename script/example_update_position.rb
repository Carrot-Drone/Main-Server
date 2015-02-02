#!/usr/bin/env/rails r

ress = Restaurant.all
ress.each do |res|
  menus = res.menus

  cnt = 1
  menus.each do |menu|
    menu.position = cnt
    menu.save
    puts menu.name.to_s + menu.position.to_s
    cnt = cnt + 1
  end
end
