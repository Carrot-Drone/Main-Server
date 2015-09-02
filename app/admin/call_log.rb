ActiveAdmin.register CallLog do
  actions :all, :except => [:new, :edit, :show]
  index do
    column "Campus" do |call_log|
      restaurant = call_log.restaurant
      if not restaurant == nil
        raw Campus.find_by_id(restaurant.categories.first.campus_id).name_kor
      else
        raw ""
      end
    end
    column "Restaurant" do |call_log|
      restaurant = call_log.restaurant
      if not restaurant == nil
        raw restaurant.name
      else 
        raw ""
      end
    end
    column :phoneNumber
    column :device_type
    column :has_recent_call
    column :created_at

    if current_admin.is_super_admin == true
      actions
    end
  end

  config.filters = false
end
