class User < ActiveRecord::Base
  has_many :devices

  has_many :users_restaurants
  has_many :restaurants, :through => :users_restaurants
end
