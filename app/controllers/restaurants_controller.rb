class RestaurantsController < ApplicationController
  skip_before_filter  :verify_authenticity_token
  def new_menu
    restaurant = Restaurant.all.select {|r| r.campus == "Yongon" and r.phone_number == params[:phoneNumber].delete(' ')}.first

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

  def index
  end

  def show
  end
end
