class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many :tags

  def self.owned_res(current_admin)
    tags = current_admin.tags.to_a
    tags.map! {|x| x.tag_name}
    a = Restaurant.all.select {|x| tags.include? x.campus }
    Restaurant.where(id: a.map(&:id))
  end
end

class Tag < ActiveRecord::Base
  has_and_belongs_to_many :admins
end
