class Device < ActiveRecord::Base
  has_many :call_logs
  belongs_to :campus
  belongs_to :user
end 

