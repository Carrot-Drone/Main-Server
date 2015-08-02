class CampusesController < ApplicationController
  def campuses
    @json = Campus.all.select {|x| x.is_confirmed? }

    render json: @json, :only => [:name_eng, :name_kor, :name_kor_short, :email]
  end

  def campuses_all
    @json = Campus.all

    render json: @json, :only => [:name_eng, :name_kor, :name_kor_short, :email]
  end

  def restaurants
    campus_id = params[:campus_id]
    campus = Campus.find(campus_id)

    @json = campus.categories.to_json(
      :include => {
        :restaurants => {
          :except => [:updated_at, :created_at],
          :methods => [:flyers_url, :number_of_my_calls, :total_number_of_calls, :my_preference, :retention, :has_flyer], 
          :include => {
            :menus =>{
              :except => [:id, :created_at, :updated_at],
              :include => :submenus
            }
          }
        }
      }
    )
    render json: @json 
  end

  def restaurants_in_category
    #campus_id = params[:campus_id]
    category_id = params[:category_id]
    category = Category.find(category_id)
    restaurants = category.restaurants

    @json = restaurants.to_json(
      :only => [:id, :name, :phone_number, :has_coupon, :is_new, :retention, :updated_at],
      :methods => [:has_flyer]
    )
    render json: @json
  end 
end
