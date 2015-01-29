class Menu < ActiveRecord::Base
  belongs_to :restaurant, touch: true
  acts_as_list
end
