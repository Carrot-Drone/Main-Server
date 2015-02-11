class Flyer < ActiveRecord::Base
  belongs_to :restaurant, touch: true

  mount_uploader :flyer, FlyerUploader
end
