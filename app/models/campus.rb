class Campus < ActiveRecord::Base
  has_many :restaurants
  has_many :devices
end
