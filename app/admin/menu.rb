ActiveAdmin.register Menu do
  menu priority: 1
  belongs_to :restaurant
  navigation_menu :restaurant

  permit_params :section, :name, :price, :position

  config.sort_order = 'position_asc'
  config.paginate = false

  sortable

  index do
    sortable_handle_column
    selectable_column
    id_column
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
    def update
      update! do |format|
        format.html { redirect_to admin_restaurant_menus_path }
      end
    end
    def create
      create! do |format|
        format.html { redirect_to_admin_restaurant_menus_path  }
      end
    end
  end
end
