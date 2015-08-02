class User < ActiveRecord::Base
  has_many :devices

  has_many :users_restaurants
  has_many :restaurants, :through => :users_restaurants

  has_many :call_logs

  has_many :user_requests
  has_many :user_corrections
  has_many :restaurant_suggestions
end
