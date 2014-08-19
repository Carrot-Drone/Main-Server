class Flyer < ActiveRecord::Base
  belongs_to :restaurant

  mount_uploader :flyer, FlyerUploader
end
