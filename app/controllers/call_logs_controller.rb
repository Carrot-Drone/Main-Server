class CallLogsController < ApplicationController
  skip_before_filter  :verify_authenticity_token
  def new_call
    Rails.logger.info params
    @phoneNumber = params[:phoneNumber]
    @phoneNumber = @phoneNumber.delete(' ')

    call_log = CallLog.new
    call_log.phoneNumber = @phoneNumber
    call_log.device = params[:device]
    call_log.campus = params[:campus]
    call_log.save
=begin
    restaurants = Restaurant.find_all_by_phone_number(@phoneNumber)
    if restaurants.count == 0
      restaurant = Restaurant.new
      restaurant.name = params[:name]
      restaurant.phone_number = @phoneNumber
    else
      restaurant = restaurants[0] 
    end
    restaurant.call_logs.push(call_log)
    restaurant.campus = call_log.campus
    restaurant.save
=end
    render :nothing => true
  end
end
