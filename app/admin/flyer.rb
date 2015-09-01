ActiveAdmin.register Flyer do
  menu false
  #belongs_to :restaurant
  #belongs_to :restaurant_suggestion

  permit_params :flyer, :restaurant_id, :restaurant_suggestion_id

  sidebar "Back to", only: [:index] do
    ul do
      if params[:category_id] != nil
        li link_to "Restaurants", admin_category_restaurants_path(params[:category_id])
        li link_to "Categories", admin_campus_categories_path(Category.find(params[:category_id]).campus_id)
        li link_to "Campuses", admin_campuses_path
      end
    end
  end

  form do |f|
    inputs 'Details' do
      if params[:restaurant_id] != nil or params[:restaurant_id] != 0
        input :restaurant, as: :select, collection: [Restaurant.find(params[:restaurant_id])],
          include_blank: false
      end
      input :flyer
    end
  end

  controller do
    belongs_to :restaurant, :restaurant_suggestion, polymorphic: true
    before_action :set_flyer, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_flyer, only: [:set_flyer]

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_flyer
      @flyer = Flyer.find(params[:id])
    end

    def authenticate_flyer
      if current_admin == nil and @flyer.restaurant != nil
        redirect_to :root
      elsif not Admin.owned_campus(current_admin).map{|x| x.name_eng}.include? @flyer.restaurant.categories.first.campus.name_eng
        redirect_to :root
      end
    end
  end
end
