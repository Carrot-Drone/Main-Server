class Restaurant < ActiveRecord::Base
  has_many :call_logs
  has_many :menus
  has_many :flyers
  serialize :phone_numbers

  def hasPhoneNumber?(phone_number)
    return self.phone_numbers.include?(phone_number)
  end

  def flyers_url
    flyers = Array.new
    for flyer in self.flyers
      flyers.push(flyer.flyer.url)
    end
    return flyers
  end
end
