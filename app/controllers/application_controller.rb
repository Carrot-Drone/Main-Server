class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception
  
  def authenticate_admin_user!
     redirect_to new_admin_session_path if current_admin == nil
  end

  def minimum_app_version
    @json = Hash.new
    @json[:minimum_ios_version] = "3.0.1"
    @json[:ios_appstore_url] = "https://itunes.apple.com/kr/app/id726115856"
    @json[:minimum_android_version] = "300"

    render json: @json
  end





  # Parse json to audo create campus data
  def campus
    campus_json = params['campus']
    campus_name = campus_json['name']
    campus = Campus.where(name_kor: campus_name).take
    if campus == nil
      Rails.logger.info "New Campus!"
      campus = Campus.new
      campus.name_kor = campus_name
      campus.save

      cat_array = ["치킨", "피자", "중국집", "한식/분식", "도시락/돈까스", "족발/보쌈", "냉면", "기타"]
      cat_array.each do |title|
        category = Category.new
        category.title = title
        category.campus = campus
        category.save
      end
    end

    campus_json['categories'] ||= []
    campus_json['categories'].each do |key, value|
      title = key.gsub(/\s+/, "")
      category = Category.where(campus_id: campus.id).where(title: title).take
      if category == nil
        Rails.logger.error "Error! Unkown Category"
        category = Category.new
        category.title = key
        category.campus = campus
        category.save
      end

      value ||= []
      value.each do |res_json|
        restaurants = category.restaurants.select {|r| r.phone_number.gsub(/[^0-9]/, "") == res_json['phone_number'].gsub(/[^0-9]/, "")}
        restaurant = nil
        if restaurants.count > 1
          Rails.logger.error "Error! Duplicated Restaurant Phonenumber"
        elsif restaurants.count == 1
          restaurant = restaurants[0]
        else
          # New Restaurant
          restaurant = Restaurant.new
        end

        # Set Restaurant
        restaurant.name = res_json['name']
        res_json['phone_number'] ||= ""
        phone_number = res_json['phone_number'].gsub(/[^0-9]/, "")
        restaurant.phone_number = parse_phone_number(phone_number)
        restaurant.notice = res_json['notice']

        res_json['opening_hours'] ||= ""
        res_json['opening_hours'].gsub!(/[^0-9,.]/, "")

        res_json['closing_hours'] ||= ""
        res_json['closing_hours'].gsub!(/[^0-9,.]/, "")

        if res_json['opening_hours'] != "0"
          restaurant.opening_hours = res_json['opening_hours'].to_f
        end
        if res_json['closing_hours'] != "0"
          restaurant.closing_hours = res_json['closing_hours'].to_f
        end

        restaurant.categories.push(category)
        restaurant.save

        # Remove existing Menus
        restaurant.menus.each do |menu|
          menu.submenus.each do |submenu|
            submenu.destroy
          end
          menu.destroy
        end

        res_json['menus'] ||= []
        res_json['menus'].each do |menu_json|
          menu = Menu.new
          menu.name = menu_json['name']
          menu_json['price'] ||= "0"
          menu_json['price'].gsub!(/[^0-9,.]/, "")
          menu.price = menu_json['price'].to_i
          menu.section = menu_json['section']
          menu.description = menu_json['description']
          menu.restaurant = restaurant
          menu.save

          menu_json['submenus'] ||= []
          menu_json['submenus'].each do |submenu_json|
            submenu = Submenu.new
            submenu.name = submenu_json['name']
            submenu.price = submenu_json['price'].to_i
            submenu.menu = menu
            submenu.save
          end
        end
      end
    end

    render nothing: true, status: :ok
  end

  def parse_phone_number(str)
    str.gsub!(/[^0-9,.]/, "")
    if str[0] != '0'
      return str[0..3] + "-" + str[4..-1]
    elsif str[1] == '2'
      if str.length <= 9
        return str[0..1] + "-" + str[2..4] + "-" + str[5..-1]
      else
        return str[0..1] + "-" + str[2..5] + "-" + str[6..-1]
      end
    else
      if str.length <= 10
        return str[0..2] + "-" + str[3..5] + "-" + str[6..-1]
      else
        return str[0..2] + "-" + str[3..6] + "-" + str[7..-1]
      end
    end
  end
end
