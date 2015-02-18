class Menu < ActiveRecord::Base
  belongs_to :restaurant, touch: true
  acts_as_list

  validates :section, :name, :price, presence: true
  before_validation :save_menu!

  private
    def save_menu!
      if self.price == nil
        self.price = 0
      end
    end
end
