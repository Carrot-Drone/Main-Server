ActiveAdmin.register Campus do
  actions :all, :except => [:new, :show]
  permit_params :name_kor, :description

  index do
    id_column
    column :name_eng
    column :name_kor
    column :description
    column "Restaurants" do |campus|
      link_to('음식점 리스트', admin_campus_restaurants_path(campus))
    end
  end 

  form do |f|
    inputs 'Details' do
      input :name_kor
      input :description
    end
    actions
  end

  controller do
    def index
      params[:order] = ""
      super
    end 
    def scoped_collection
      Admin.owned_campus(current_admin)
    end
  end
end
