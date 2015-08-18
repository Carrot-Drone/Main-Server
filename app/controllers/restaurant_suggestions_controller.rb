class RestaurantSuggestionsController < ApplicationController
  skip_before_filter  :verify_authenticity_token
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
      rsu.is_suggested_by_restaurant = is_suggested_by_restaurant == "1"

      if files != nil and files.count != 0
        files.each_with_index do |data, index|
          data = Base64.decode64(data)
          data = self.hex_to_string(data)
          data = StringIO.new(data)
          #data = StringIO.new(Base64.decode64(data))
          data.class.class_eval {attr_accessor :original_filename, :content_type}
          data.original_filename = "test1.jpeg"
          data.content_type = "image/jpeg"
          
          flyer = Flyer.new
          flyer.restaurant_suggestion = rsu
          flyer.flyer = data
          flyer.save!

          GC.start
        end
      end
      rsu.save

      render nothing: true, status: :ok
    else 
      render nothing: true, status: :bad_request
    end
  end 

  def hex_to_string(hex)
    temp = hex.gsub("\s", "");
    ret = []
    (0...temp.size()/2).each{|index| ret[index] = [temp[index*2, 2]].pack("H2")}
    file = String.new
    ret.each { |x| file << x}
    file  
  end

end
