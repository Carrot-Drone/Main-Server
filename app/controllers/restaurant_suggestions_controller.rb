class RestaurantSuggestionsController < ApplicationController
  def create
    uuid = params[:uuid]
    campus_id = params[:campus_id]
    name = params[:name]
    phone_number = params[:phone_number]
    office_hours = params[:office_hours]
    files = params[:files]
    is_suggested_by_restaurant = params[:is_suggested_by_restaurant]

    device = Device.find_by_uuid(uuid)
    user = nil
    if device != nil
      user = device.user
    end

    if campus_id != nil and name != nil and phone_number != nil
      rsu = RestaurantSuggestion.new
      rsu.user = user
      rsu.campus_id = campus_id
      rsu.campus_name = name
      rsu.restaurant_phone_number = phone_number
      rsu.restaurant_office_hours = office_hours
      rsu.is_suggested_by_restaurant = is_suggested_by_restaurant == "true"
      if files != nil and files.count != 0
        files.each do |file|
          flyer = Flyer.new
          flyer.restaurant_suggestion = rsu
          flyer.flyer = file
          flyer.save
        end
      end
      rsu.save

      render nothing: true, status: :ok
    else 
      render nothing: true, status: :bad_request
    end
  end 
end
