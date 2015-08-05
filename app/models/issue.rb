class Issue < ActiveRecord::Base
  belongs_to :ticket
  validates :description,   presence: true
end
