class DevicesController < ApplicationController
  def update
    uuid = params[:uuid]
    type = params[:device_type]
    campus_id = params[:campus_id]

    if uuid == nil or type == nil or campus_id == nil
      render :nothing => true, :status => :bad_request
    end

    device = Device.find_by_uuid(uuid)
    if device == nil
      device = Device.new
      device.uuid = uuid
      device.device_type = type
      
      user = User.new
      user.devices.push(device)
      user.save
    end

    device.campus = Campus.find(campus_id)
    device.save
    render :nothing => true, :status => :ok
  end

  # Deprecated API
  def update_device_deprecated
    if params[:uuid] == nil or params[:device] == nil or params[:campus] == nil
      render :nothing => true, :status => 400, :content_type => 'text/html'
    end

    @device = Device.find_by_uuid(params[:uuid])
    if @device == nil
      @device = Device.new
      @device.uuid = params[:uuid]
    end

    @device.device_type = params[:device]
    @device.campus = Campus.find_by_name_eng(params[:campus])
    @device.save

    if @device.user == nil
      @user = User.new
      @user.devices.push(@device)
      @user.save
    end

    render :nothing => true, :status => 200, :content_type => 'text/html'
  end
end
