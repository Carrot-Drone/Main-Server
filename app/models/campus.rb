class Campus < ActiveRecord::Base
  has_many :restaurants
  has_many :devices
  default_scope order('name_kor')
end
