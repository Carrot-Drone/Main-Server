class Category < ActiveRecord::Base
  belongs_to :campus
  has_and_belongs_to_many :restaurants

  has_many :call_logs

end
