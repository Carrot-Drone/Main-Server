ActiveAdmin.register Menu do
  menu priority: 1
  belongs_to :restaurant

  permit_params :section, :name, :price, :position

  config.sort_order = 'position_asc'
  config.paginate = false

  sortable

  index do
    sortable_handle_column
    selectable_column
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
    before_action :set_menu, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_menu, only: [:show, :edit, :update, :destroy]
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
        format.html { redirect_to admin_restaurant_menus_path  }
      end
    end
    private

    # Use callbacks to share common setup or constraints between actions.
    def set_menu
      @menu = Menu.find(params[:id])
    end

    def authenticate_menu
      if current_admin == nil
        redirect_to :root
      elsif not Admin.owned_campus(current_admin).map{|x| x.name_eng}.include? @menu.restaurant.campus_model.name_eng
        redirect_to :root
      end
    end
  end
end
