class CampusesController < ApplicationController
  def show
    campus = Campus.find(params[:campus_id])
    if campus == nil
      render nothing: true, status: :bad_request
    else
      render json: campus, :only => [:id, :name_eng, :name_kor, :name_kor_short, :email, :administrator]
    end
  end 
  def campuses
    all = params[:all] == "1"
    campuses = nil
    if all
      # For Test APK
      campuses = Campus.all
    else
      campuses = Campus.all.select {|x| x.is_confirmed? }
    end

    render json: campuses, :only => [:id, :name_eng, :name_kor, :name_kor_short, :email, :administrator]
  end

  def restaurants
    campus_id = params[:campus_id]
    campus = Campus.find(campus_id)

    json = nil
    Dir.mkdir("#{Rails.root}/public/campuses") unless Dir.exists?("#{Rails.root}/public/campuses")
    Dir.mkdir("#{Rails.root}/public/campuses/cached_data") unless Dir.exists?("#{Rails.root}/public/campuses/cached_data")
    if File.exist?("#{Rails.root}/public/campuses/cached_data/#{campus.id}.json")
      if File.ctime("#{Rails.root}/public/campuses/cached_data/#{campus.id}.json") > Time.now - 60*60*24
        json = File.read("#{Rails.root}/public/campuses/cached_data/#{campus.id}.json")
      end
    end

    if json == nil
      json = campus.categories.to_json(
        :include => {
          :restaurants => {
            :except => [:updated_at, :created_at],
            :methods => [:flyers_url, :number_of_my_calls, :total_number_of_calls, :my_preference, :retention, :has_flyer, :is_new, :total_number_of_goods, :total_number_of_bads], 
            :include => {
              :menus =>{
                :except => [:created_at, :updated_at],
                :include => :submenus
              }
            }
          }
        }
      )
      if File.exist?("#{Rails.root}/public/campuses/cached_data/#{campus.id}.json")
        File.delete("#{Rails.root}/public/campuses/cached_data/#{campus.id}.json")
      end
      file = File.open("#{Rails.root}/public/campuses/cached_data/#{campus.id}.json", "w")
      file.write(json)
    end

    render json: json 
  end

  def restaurants_in_category
    #campus_id = params[:campus_id]
    category_id = params[:category_id]
    category = Category.find(category_id)
    restaurants = category.restaurants

    @json = restaurants.to_json(
      :only => [:id, :name, :phone_number, :has_coupon, :retention, :opening_hours, :closing_hours],
      :methods => [:has_flyer, :is_new]
    )
    render json: @json
  end 

  def recommended_restaurants
    campus = Campus.find(params[:campus_id])
    restaurants = campus.categories.map{|cat| cat.restaurants}.flatten
    restaurants = restaurants.sort_by{|r| r.total_number_of_calls}

    trend = restaurants.reverse[1...10]
    trend = trend.map{|r| {:id => r.id, :reason => "우리 학교 트랜드"}}

    new = restaurants[1...10] 
    new = new.map{|r| {:id => r.id, :reason => "캠달에 처음이에요"}}

    json = {"new" => new, "trend" => trend}.to_json

    render json: json
  end


  # Deprecated API
  def campuses_all
    json = Campus.all

    render json: json, :only => [:id, :name_eng, :name_kor, :name_kor_short, :email]
  end
end
