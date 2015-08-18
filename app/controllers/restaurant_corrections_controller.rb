class RestaurantCorrectionsController < ApplicationController
  skip_before_filter  :verify_authenticity_token
  def create
    restaurant_id = params[:restaurant_id]
    major_correction = params[:major_correction]
    details = params[:details]
    uuid = params[:uuid]
    device = Device.find_by_uuid(uuid)
    user = device.user

    if restaurant_id != nil and major_correction != nil and details != nil and user != nil
      rc = RestaurantCorrection.new
      rc.restaurant_id = restaurant_id
      rc.major_correction = major_correction
      rc.details = details
      rc.save
      render nothing: true, status: :ok
    else
      render nothing: true, status: :bad_request
    end

  end
end
