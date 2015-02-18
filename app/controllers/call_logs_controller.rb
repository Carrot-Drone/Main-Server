class CallLogsController < ApplicationController
  skip_before_filter  :verify_authenticity_token
  def new
    @phoneNumber = params[:phoneNumber]
    if not @phoneNumber == nil
      @phoneNumber = @phoneNumber.delete(' ')
    end

    call_log = CallLog.new
    call_log.phoneNumber = @phoneNumber
    call_log.device_type = params[:device]
    call_log.campus = params[:campus]

    # set restaurant
    restaurants = Array.new
    Restaurant.all.each do |r|
      if r.hasPhoneNumber?(@phoneNumber)
        restaurants.push(r)
      end
    end
    if params[:campus] != nil
      restaurant = restaurants.select {|r| r.campus == params[:campus]}[0]
      restaurant.call_logs.push(call_log)
      restaurant.save
    end

    # set device
    if not params[:uuid] == nil
      device = Device.find_by_uuid(params[:uuid])
      if device == nil
        device = Device.new
        device.uuid = params[:uuid]
      end

      device.device_type = params[:device]
      device.campus = Campus.find_by_name_eng(params[:campus])

      call_log.device = device
      device.save
    end

    call_log.save

    render :nothing => true
  end

  def index
    @call_logs = CallLog.order("id DESC").page(params[:page])
  end

  def destroy
    @call_log = CallLog.find(params[:id])
    @call_log.destroy

    redirect_to call_logs_path
  end

  def statistic
  end
end
