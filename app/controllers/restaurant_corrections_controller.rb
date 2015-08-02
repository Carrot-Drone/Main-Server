class RestaurantCorrectionsController < ApplicationController
  def create
    restaurant_id = params[:restaurant_id]
    major_correction = params[:major]
    details = params[:details]

    if restaurant_id != nil and major_correction != nil and details != nil
      rc = RestaurantCorrection.new
      rc.restaurant_id = restaurant_id
      rc.major_correction = major_correction
      rc.details = details
      rc.save
    end

    render nothing: true, status: :ok
  end
end
