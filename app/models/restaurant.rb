class Restaurant < ActiveRecord::Base
  has_and_belongs_to_many :categories 
  has_many :menus, -> { order(:position)}
  has_many :flyers

  has_many :users_restaurants
  has_many :users, :through => :users_restaurants

  has_many :call_logs

  serialize :phone_numbers

  validates :name, :phone_number, presence: true
  validates_format_of :phone_number, :with => /[0-9]+/, :message => "올바른 형식의 전화번호를 입력해주세요.\n ex) 00-000-0000"

  before_save :save_restaurants!

  # Method For to_json
  attr_accessor :uuid
  attr_accessor :category

  def flyers_url
    flyers = Array.new
    for flyer in self.flyers
      flyers.push(flyer.flyer.url)
    end
    return flyers
  end

  def number_of_calls
    if @uuid == nil || Device.find_by_uuid(@uuid) == nil
      return 0
    else
      device = Device.find_by_uuid(@uuid)
      user = device.user
      usersRestaurant = UsersRestaurant.where("user_id =? AND restaurant_id = ?", user.id, self.id).first
      if usersRestaurant != nil
        return usersRestaurant.number_of_calls_for_user
      else
        return 0
      end
    end
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
