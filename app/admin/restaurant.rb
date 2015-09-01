ActiveAdmin.register Restaurant do
  #belongs_to :campus#, :class_name => "Campus"
  belongs_to :category
  permit_params :name, :phone_number, :campus, :category, :opening_hours, :closing_hours, :has_coupon, :flyer, :notice, :minimum_price

  index do
    selectable_column
    column "Campus" do |res|
      raw Category.find(params[:category_id]).campus.name_kor_short
    end   
    column :category do |res|
      raw Category.find(params[:category_id]).title
    end
    column :name       
    column :phone_number
    column :opening_hours
    column :closing_hours

    column "Menus" do |res|
      link_to '메뉴', admin_restaurant_menus_path(res, :category_id => params[:category_id])
    end
    column "Flyer" do |res|
      link_to('전단지', admin_restaurant_flyers_path(res, :category_id => params[:category_id]))
    end
    actions
  end

  form do |f|
    inputs 'Details' do
      input :name
      input :phone_number
      #input :category, as: :select, collection: ['치킨', '피자', '중국집', '한식/분식', '도시락/돈까스', '족발/보쌈', '냉면', '기타'],
      #  include_blank: false
      #input :category, as: :select, collection: [Category.find(params[:category_id]).title],
      #  include_blank: false

      input :opening_hours
      input :closing_hours
      input :has_coupon
      input :notice, label: "Notice"
      input :minimum_price
    end
    actions
  end

  filter :name

  controller do
    before_action :set_restaurant, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_restaurant, only: [:show, :edit, :create, :update, :destroy]

    def index
      params[:order] = ""
      super
      if params[:category_id]
        @restaurants = Category.find(params[:category_id]).restaurants
      end
    end

    def create
      super
      category = Category.find(params[:category_id])
      @restaurant.categories.push(category)
    end

    def update
      update! do |format|
        format.html { redirect_to admin_category_restaurants_path  }
      end
    end

    def destroy
      destroy! do |format|
        format.html { redirect_to admin_category_restaurants_path }
      end
    end

    def scoped_collection
      a = super
      a = a.order('name')
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_restaurant
      @restaurant = Restaurant.find(params[:id])
      params[:category_id] ||= @restaurant.categories[0].id
    end

    def authenticate_restaurant
      if current_admin == nil
        redirect_to :root
        false
      elsif current_admin.is_super_admin == true
      elsif not Admin.owned_campus(current_admin).map{|campus| campus.categories.map{|c| c.id}}.flatten.include? params[:category_id].to_i
        Rails.logger.error "ABC"
        redirect_to :root
        false 
      end
    end
  end


  sidebar "Restaurant Details", only: [:show, :edit] do
    ul do
      li link_to "Menus",admin_restaurant_menus_path(restaurant, :category_id => params[:category_id])
      li link_to "Flyers", admin_restaurant_flyers_path(restaurant, :category_id => params[:category_id])
    end
  end

  sidebar "Back to", only: [:index, :show] do
    ul do
      if params[:category_id] != nil
        li link_to "Categories", admin_campus_categories_path(Campus.find(Category.find(params[:category_id]).campus_id))
        li link_to "Campuses", admin_campuses_path
      end
    end
  end
end
