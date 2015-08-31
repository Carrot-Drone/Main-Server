class CallLog < ActiveRecord::Base
  belongs_to :campus
  belongs_to :category
  belongs_to :restaurant, touch: true
  belongs_to :user
  belongs_to :device
end
