class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def self.owned_campus(current_admin)
      a = Campus.all
    if not current_admin.is_super_admin
      a = a.select {|x| x.email == current_admin.email}
    end
    Campus.where(id: a.map(&:id))
  end

  def self.owned_restaurant_suggestion(current_admin)
    a = nil
    if current_admin.is_super_admin
      a = RestaurantSuggestion.all
    else
      a = RestaurantSuggestion.all.select do |rs|
        rs.campus.email == current_admin.email
      end
    end
    RestaurantSuggestion.where(id: a.map(&:id))
  end

  def self.owned_restaurant_correction(current_admin)
    a = nil
    if current_admin.is_super_admin
      a = RestaurantCorrection.all
    else
      a = RestaurantCorrection.all.select do |rc|
        rc.restaurant.categories[0].campus.eamil = current_admin.email
      end
    end
    RestaurantCorrection.where(id: a.map(&:id))
  end

end
