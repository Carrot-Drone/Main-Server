ActiveAdmin.register CallLog do
  actions :all, :except => [:new, :show]
  index do
    column "Campus" do |call_log|
      restaurant = call_log.restaurant
      if not restaurant == nil
        raw Campus.find_by_id(restaurant.campus_id).name_kor
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
    column :created_at
  end

  config.filters = false
end
