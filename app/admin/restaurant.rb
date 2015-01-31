ActiveAdmin.register Restaurant do
  permit_params :name, :phone_number, :campus, :category, :openingHours, :closingHours, :has_flyer, :has_coupon, :flyer, :is_new, :coupon_string

  index do
    selectable_column
    id_column
    column :category
    column :name       
    column :phone_number
    column :campus
    actions
  end

  form do |f|
    inputs 'Details' do
      input :name
      input :phone_number
      input :campus
      input :category
      input :openingHours
      input :closingHours
      input :has_flyer
      input :has_coupon
      input :coupon_string
      input :is_new
    end
  end

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
  menu priority: 1
  belongs_to :restaurant
  navigation_menu :restaurant


  permit_params :section, :name, :price, :position

  config.sort_order = 'position_asc'
  config.paginate = false

  sortable

  index do
    panel "New Menu" do
      @menu = Menu.new
      params[:batch_action]
      render partial: 'charts'
    end
    sortable_handle_column
    selectable_column
    id_column
    column :position
    column :section
    column :name
    column :price
    column :updated_at
    actions
  end

  form do |f|
    inputs 'Details' do
      input :section
      input :name
      input :price
      actions
    end
  end

  controller do
    def index
      @menu = Menu.new
      super
    end
  end
end

ActiveAdmin.register Flyer do
  belongs_to :restaurant
  navigation_menu :restaurant

  permit_params :flyer, :restaurant_id
end
