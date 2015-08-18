class UserRequestsController < ApplicationController
  skip_before_filter  :verify_authenticity_token
  def create
    uuid = params[:uuid]
    email = params[:email]
    details = params[:details]

    if uuid != nil and email != nil and details != nil
      ur = UserRequest.new

      device = Device.find_by_uuid(uuid)
      user = nil
      if device != nil
        user = device.user
      end

      ur.user = user
      ur.email = email
      ur.details = details 
      ur.save

      render nothing: true, status: :ok
    else
      render nothing: true, status: :bad_request
    end

  end
end
