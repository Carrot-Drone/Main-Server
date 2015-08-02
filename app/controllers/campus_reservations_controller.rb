class CampusReservationsController < ApplicationController
  def create
    name = params[:campus_name]
    phone_number = params[:phone_number]

    if name != nil and phone_number != nil
      r = CampusReservation.new 
      r.campus_name = name
      r.phone_number = phone_number
      r.save
    end
    render nothing: true, status: :ok
  end
end
