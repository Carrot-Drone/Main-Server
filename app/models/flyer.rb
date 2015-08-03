class Flyer < ActiveRecord::Base
  belongs_to :restaurant, touch: true
  belongs_to :restaurant_suggestion

  mount_uploader :flyer, FlyerUploader
end
