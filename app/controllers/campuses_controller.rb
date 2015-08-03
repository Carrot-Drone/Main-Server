class CampusesController < ApplicationController
  def campuses
    all = params[:all] == "true"
    campuses = nil
    if all
      # For Test APK
      campuses = Campus.all
    else
      campuses = Campus.all.select {|x| x.is_confirmed? }
    end

    render json: campuses, :only => [:id, :name_eng, :name_kor, :name_kor_short, :email]
  end

  def restaurants
    campus_id = params[:campus_id]
    campus = Campus.find(campus_id)

    @json = campus.categories.to_json(
      :include => {
        :restaurants => {
          :except => [:updated_at, :created_at],
          :methods => [:flyers_url, :number_of_my_calls, :total_number_of_calls, :my_preference, :retention, :has_flyer, :is_new, :total_number_of_goods, :total_number_of_bads], 
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
      :only => [:id, :name, :phone_number, :has_coupon, :retention, :updated_at],
      :methods => [:has_flyer, :is_new]
    )
    render json: @json
  end 


  # Deprecated API
  def campuses_all
    json = Campus.all

    render json: json, :only => [:id, :name_eng, :name_kor, :name_kor_short, :email]
  end
end
