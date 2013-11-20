class Restaurant < ActiveRecord::Base
  has_many :call_logs
end
