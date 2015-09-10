ActiveAdmin.register RestaurantCorrection do
  permit_params :is_processed, :details, :major_correction

  index do
    column :major_correction
    column :details
    column :created_at
    column "Restaurant" do |rc|
      res = rc.restaurant
      link_to(res.name, admin_restaurant_path(res))
    end
    column :is_processed
    if current_admin.is_super_admin?
      actions
    end
  end

  controller do
    def scoped_collection
      Admin.owned_restaurant_correction(current_admin)
    end
  end
end
