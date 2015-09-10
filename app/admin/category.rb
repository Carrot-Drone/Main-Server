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

  config.clear_sidebar_sections!

  index do
    column "Campus" do |category|
      raw category.campus.name_kor
    end
    column :title
    column "# of res" do |category|
      raw category.restaurants.count
    end
    column "Restaurants" do |category|
      link_to('Go to List', admin_category_restaurants_path(category))
    end
  end

  sidebar "Back to Campuses", only: [:index] do
    ul do
      li link_to "Campuses", admin_campuses_path
    end
  end

end
