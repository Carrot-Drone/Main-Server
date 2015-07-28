ActiveAdmin.register Category do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end
  actions :all, :except => [:new, :show, :destroy, :edit]
  belongs_to :campus

  index do
    column :title
    column "Restaurants" do |category|
      link_to('Go to List', admin_category_restaurants_path(category))
    end
  end

  filter :false
end
