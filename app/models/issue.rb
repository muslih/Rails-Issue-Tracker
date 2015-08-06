class Issue < ActiveRecord::Base
  belongs_to :ticket
  belongs_to :user
  validates :description,   presence: true
end
