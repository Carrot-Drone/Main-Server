class Campus < ActiveRecord::Base
  scope :name_kor, -> { order("name_kor ASC") }
  default_scope { name_kor }

  has_many :categories
  has_many :restaurants
  has_many :devices
end
