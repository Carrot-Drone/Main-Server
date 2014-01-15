class CallLogsController < ApplicationController
  skip_before_filter  :verify_authenticity_token
  def new
    Rails.logger.info params
    @phoneNumber = params[:phoneNumber]
    @phoneNumber = @phoneNumber.delete(' ')

    call_log = CallLog.new
    call_log.phoneNumber = @phoneNumber
    call_log.device = params[:device]
    call_log.campus = params[:campus]
    restaurants = Restaurant.find_all_by_phone_number(@phoneNumber)
    if params[:campus] != nil
      restaurants = restaurants.select {|r| r.campus == params[:campus]}
    end
    if restaurants.count != 0
      Rails.logger.info "wow"
      restaurant = restaurants[0]
      call_log.campus = restaurant.campus
      restaurant.call_logs.push(call_log)
      restaurant.save
    end

    call_log.save

    if params[:name] != nil
      restaurants = Restaurant.find_all_by_phone_number(@phoneNumber)
      restaurants = restaurants.select {|r| r.campus == params[:campus]}
      Rails.logger.info restaurants

      if restaurants.count == 0
        restaurant = Restaurant.new
        restaurant.name = params[:name]
        restaurant.phone_number = params[:phoneNumber] 
        restaurant.campus = params[:campus] 
      else
        restaurant = restaurants[0] 
      end
      restaurant.call_logs.push(call_log)
      restaurant.save
    end

    render :nothing => true
  end

  def index
    @call_logs = CallLog.all.reverse
  end

  def destroy
    @call_log = CallLog.find(params[:id])
    @call_log.destroy

    redirect_to call_logs_path
  end

  def statistic
  end
end
