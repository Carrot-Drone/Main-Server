class Restaurant < ActiveRecord::Base
  has_many :call_logs
  has_many :menus
  serialize :phone_numbers

  def hasPhoneNumber?(phone_number)
    return self.phone_numbers.include?(phone_number)
  end
end
