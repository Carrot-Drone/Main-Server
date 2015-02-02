ActiveAdmin.register Restaurant do
  belongs_to :campus, :class_name => "Campus"
  navigation_menu :campus
  permit_params :name, :phone_number, :campus, :category, :openingHours, :closingHours, :has_flyer, :has_coupon, :flyer, :is_new, :coupon_string

  index do
    selectable_column
    id_column
    column :category
    column :name       
    column :phone_number
    column :campus
    column "Menus" do |res|
      link_to('메뉴', admin_restaurant_menus_path(res))
    end
    column "Flyer" do |res|
      link_to('전단지', admin_restaurant_flyers_path(res))
    end
    actions
  end

  form do |f|
    inputs 'Details' do
      input :name
      input :phone_number
      input :campus, as: :select, collection: current_admin.tags.map{|x| x.tag_name},
        include_blank: false
      input :category, as: :select, collection: ['치킨', '피자', '중국집', '한식/분식', '도시락/돈까스', '족발/보쌈', '냉면', '기타'],
        include_blank: false

      input :openingHours
      input :closingHours
      input :has_flyer
      input :has_coupon
      input :coupon_string
      input :is_new
    end
    actions
  end

  controller do
    def index
      params[:order] = ""
      super
    end
    def scoped_collection
      a = super
      a = a.order('campus, category, name')
      #Admin.owned_res(current_admin).order('campus, category, name')
    end
 end
  

  sidebar "Restaurant Details", only: [:show, :edit] do
    ul do
      li link_to "Menus",    admin_restaurant_menus_path(restaurant)
      li link_to "Flyers", admin_restaurant_flyers_path(restaurant)
    end
  end

end


ActiveAdmin.register Flyer do
  belongs_to :restaurant

  permit_params :flyer, :restaurant_id
end
