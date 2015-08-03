class RestaurantSuggestion < ActiveRecord::Base
  belongs_to :user
  has_many :flyers
end
