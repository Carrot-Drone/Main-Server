class RestaurantSuggestionsController < ApplicationController
  def create
    uuid = params[:uuid]
    campus_id = params[:campus_id]
    name = params[:name]
    phone_number = params[:phone_number]
    opening_hours = params[:opening_hours]
    closing_hours = params[:closing_hours]
    files = params[:files]

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
      rsu.restaurant_opening_hours = opening_hours
      rsu.restaurant_closing_hours = closing_hours
      if files != nil and files.count != 0
        files.each do |file|
          flyer = Flyer.new
          flyer.restaurant_suggestion = rsu
          flyer.flyer = file
          flyer.save
        end
      end
      rsu.save

      render json: rsu.to_json(:only => [:id])
    else 
      render nothing: true, status: :bad_request
    end
  end 
end
