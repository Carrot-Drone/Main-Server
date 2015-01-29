class Restaurant < ActiveRecord::Base
  has_many :call_logs
  has_many :menus, :order => "position ASC"
  has_many :flyers
  serialize :phone_numbers

  validates :name, presence: true
  validates :phone_number, presence: true
  validates_format_of :phone_number, :with => /[0-9]+\-[0-9]+\-[0-9]/, :message => "올바른 형식의 전화번호를 입력해주세요.\n ex) 00-000-0000"


  before_save :save_restaurants!


  def hasPhoneNumber?(phone_number)
    return self.phone_number == phone_number
#    return self.phone_numbers.include?(phone_number)
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

  private 
    def save_restaurants!
      if self.has_flyer == nil
        self.has_flyer = false
      end

      if self.has_coupon == nil
        self.has_coupon = false
      end

      if self.is_new == nil
        self.is_new = false
      end

      if self.openingHours == nil
        self.openingHours = 0.0
      end
      if self.closingHours == nil
        self.closingHours = 0.0
      end
    end
end
