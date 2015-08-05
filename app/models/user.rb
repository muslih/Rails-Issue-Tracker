class User < ActiveRecord::Base
  has_many :tickets
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name,    presence: true
  validates :last_name,     presence: true
  validates :user_type,     presence: true,
                            inclusion: { in: %w{customer technician admin} }
end
