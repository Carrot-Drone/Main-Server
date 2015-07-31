ActiveAdmin.register Campus do
  actions :all #, :except => [:new, :show, :destroy]
  # We will remove new, show, destroy action if current user is not super admin
  # check action_methods on 'controller do'
 
  permit_params do
   params = [:name_kor, :name_kor_short]
   params.push :email if current_admin.is_super_admin == true 
   params.push :is_confirmed if current_admin.is_super_admin == true
  end

  config.clear_sidebar_sections! 

  index do
    column :name_kor
    column :name_kor_short
    column :email
    column "Categories" do |campus|
      link_to('Categories', admin_campus_categories_path(campus))
    end
    #column "Restaurants" do |campus|
    #  link_to('음식점 리스트', admin_campus_restaurants_path(campus))
    #end
    column "# of res" do |campus|
      raw campus.categories.map {|c| c.restaurants }.flatten.count
    end
    column "# of user" do |campus|
      raw campus.devices.count
    end
    if current_admin.is_super_admin == true
      actions
    end
  end 

  filter :false

  form do |f|
    inputs 'Details' do
      input :name_kor
      input :name_kor_short
      if current_admin.is_super_admin == true
        input :email
        input :is_confirmed
      end
    end
    actions
  end

  controller do
    before_action :is_super_admin, only: [:new, :show, :destroy]
    def index
      params[:order] = ""
      super
    end 

    def scoped_collection
      Admin.owned_campus(current_admin)
    end

    def is_super_admin
      if current_admin.is_super_admin == false
        redirect_to :back
      else
        return true
      end
    end
  end
end
