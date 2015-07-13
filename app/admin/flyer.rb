ActiveAdmin.register Flyer do
  menu priority: 3
  belongs_to :restaurant

  permit_params :flyer, :restaurant_id
  controller do
    before_action :set_flyer, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_flyer, only: [:show, :edit, :update, :destroy]

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_flyer
      @flyer = Flyer.find(params[:id])
    end

    def authenticate_flyer
      if current_admin == nil
        redirect_to :root
      elsif not Admin.owned_campus(current_admin).map{|x| x.name_eng}.include? @flyer.restaurant.campus.name_eng
        redirect_to :root
      end
    end
  end
end
