ActiveAdmin.register Menu do
  menu priority: 2
  belongs_to :restaurant

  permit_params :section, :name, :price, :position

  config.sort_order = 'position_asc'
  config.paginate = false

  sortable

  config.clear_sidebar_sections!

  index do
    sortable_handle_column
    selectable_column
    column :position
    column :section
    column :name
    column :price
    column "Submenus" do |menu|
      link_to('하위 메뉴', admin_menu_submenus_path(menu, :category_id => params[:category_id]))
    end
    column :updated_at
    actions
  end

  form do |f|
    inputs 'Details' do
      if params[:id] != nil
       input :section
      elsif params[:section] != nil
        input :section, :input_html => {:value => params[:section]}
      else
        input :section, :input_html => {:value => ""}
      end

      input :name
      input :price
      actions
    end
  end

  action_item only:[:index] do
    link_to "Update Position", :action => "update_position", :restaurant_id => params[:restaurant_id]
  end

  sidebar "Back to", only: [:index] do
    ul do
      if params[:category_id] != nil
        li link_to "Restaurants", admin_category_restaurants_path(params[:category_id])
        li link_to "Categories", admin_campus_categories_path(Category.find(params[:category_id]).campus_id)
        li link_to "Campuses", admin_campuses_path
      end
    end
  end

  controller do
    before_action :set_menu, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_menu, only: [:show, :edit, :update, :destroy]
    def update
      update! do |format|
        format.html { redirect_to admin_restaurant_menus_path }
      end
    end
    def create
      create! do |format|
        format.html { redirect_to new_admin_restaurant_menu_path(params[:restaurant_id], {:section => @menu.section})}
      end
    end
    def destroy
      destroy! do |format|
        format.html { redirect_to admin_restaurant_menus_path }
      end
    end

    def update_position
      res_id = params[:restaurant_id]
      res = Restaurant.find(res_id)
      menus = res.menus

      cnt = 1
      menus.each do |menu|
        menu.position = cnt
        menu.save
        puts menu.name.to_s + menu.position.to_s
        cnt = cnt + 1
      end

      redirect_to :back
    end


    private
    # Use callbacks to share common setup or constraints between actions.
    def set_menu
      @menu = Menu.find(params[:id])
    end

    def authenticate_menu
      if current_admin == nil
        redirect_to :root
      elsif not Admin.owned_campus(current_admin).map{|x| x.name_eng}.include? @menu.restaurant.categories.first.campus.name_eng
        redirect_to :root
      end
    end
  end
end
