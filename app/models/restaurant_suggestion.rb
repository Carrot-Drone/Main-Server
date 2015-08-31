class RestaurantSuggestion < ActiveRecord::Base
  belongs_to :campus
  belongs_to :user
  has_many :flyers
end
