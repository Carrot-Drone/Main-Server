ActiveAdmin.register Submenu do
  belongs_to :menu
  permit_params :name, :price
  
  config.clear_sidebar_sections!
  index do
    column :name
    column :price
    actions
  end

  form do |f|
    inputs 'Details' do
      input :name
      input :price
    end
    actions
  end
  filter :false

  sidebar "Back to", only: [:index] do
    ul do
      li link_to "Menus", admin_restaurant_menus_path(Menu.find(params[:menu_id]).restaurant, :category_id => params[:category_id])
      if params[:category_id] != nil
        li link_to "Restaurants", admin_category_restaurants_path(params[:category_id])
        li link_to "Categories", admin_campus_categories_path(Category.find(params[:category_id]).campus_id)
        li link_to "Campuses", admin_campuses_path
      end
    end
  end

  controller do
    def update
      update! do |format|
        format.html {
          redirect_to admin_menu_submenus_path 
        }
      end
    end
    def create
      create! do |format|
        format.html {
          redirect_to admin_menu_submenus_path 
        }
      end
    end
    def destroy
      destroy! do |format|
        format.html {
          redirect_to admin_menu_submenus_path 
        }
      end
    end
  end
        

end
