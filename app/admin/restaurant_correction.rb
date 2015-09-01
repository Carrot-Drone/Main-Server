ActiveAdmin.register RestaurantCorrection do

  index do
    column :major_correction
    column :details
    column :created_at
    column "Restaurant" do |rc|
      res = rc.restaurant
      link_to(res.name, admin_restaurant_path(res))
    end
  end

  controller do
    def scoped_collection
      Admin.owned_restaurant_correction(current_admin)
    end
  end
end
