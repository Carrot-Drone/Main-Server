ActiveAdmin.register RestaurantSuggestion do
  permit_params :is_processed

  index do
    column "Campus" do |rs|
      if rs.campus_id == nil or rs.campus_id == 0
        raw "???"
      else
        raw Campus.find(rs.campus_id).name_kor
      end
    end
    column :campus_name
    column :restaurant_name
    column :restaurant_phone_number
    column :restaurant_office_hours
    column :is_suggested_by_restaurant
    column :is_processed
    column "Flyer" do |rs|
      link_to(rs.flyers.count, admin_restaurant_suggestion_flyers_path(rs))
    end
    column :created_at
    actions
  end

  form do |f|
    inputs :campus_name
    inputs :restaurant_name
    inputs :is_processed
    actions
  end

  config.clear_sidebar_sections!

  controller do
    def scoped_collection
      Admin.owned_restaurant_suggestion(current_admin)
    end
  end
end
