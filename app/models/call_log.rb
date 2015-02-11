class CallLog < ActiveRecord::Base
  belongs_to :restaurant
  belongs_to :device
end
