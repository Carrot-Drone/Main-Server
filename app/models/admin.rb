class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def self.owned_campus(current_admin)
      a = Campus.all
    if not current_admin.is_super_admin
      a = a.select {|x| x.email == current_admin.email}
    end
    Campus.where(id: a.map(&:id))
  end
end
