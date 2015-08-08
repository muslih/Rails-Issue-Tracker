class User < ActiveRecord::Base
  has_many :issues
  has_many :tickets
  has_many :groups, through: :group_memberships
  has_many :group_memberships, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name,    presence: true
  validates :last_name,     presence: true
  validates :role, presence: true,
                   inclusion: { in: %w(customer technician admin) }

  def name
    self.first_name + ' ' + self.last_name
  end

  def add_group(group)
    group = Group.find_by(name: group)
    group.users << self
  end
end
