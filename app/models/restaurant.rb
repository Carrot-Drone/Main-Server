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

  def call_logs_with(year, month)
    if year == nil or month == nil
      return self.call_logs 
    end
    logs = self.call_logs
    return logs.select! { |log| log.created_at.year == 2000 and log.created_at.month == month }
  end
end
