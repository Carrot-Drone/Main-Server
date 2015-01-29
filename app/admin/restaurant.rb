ActiveAdmin.register Restaurant do
  index do
    selectable_column
    id_column
    column :category
    column :name       
    column :phone_number
    column :campus
    actions
  end

  permit_params :name, :phone_number, :campus, :category, :openingHours, :closingHours, :has_flyer, :has_coupon, :flyer, :is_new, :coupon_string

  controller do
    def index
      params[:order] = ""
      super
    end
    def scoped_collection
      Admin.owned_res(current_admin).order('campus, category, name')
    end
  end

  sidebar "Restaurant Details", only: [:show, :edit] do
    ul do
      li link_to "Menus",    admin_restaurant_menus_path(restaurant)
      li link_to "Flyers", admin_restaurant_flyers_path(restaurant)
    end
  end
end

ActiveAdmin.register Menu do
  belongs_to :restaurant

  permit_params :section, :name, :price, :restaurant_id

  index do
    selectable_column
    id_column
    column :section
    column :name
    column :price
    actions
  end
end

ActiveAdmin.register Flyer do
  belongs_to :restaurant

  permit_params :flyer, :restaurant_id
end
