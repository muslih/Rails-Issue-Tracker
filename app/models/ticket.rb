class Ticket < ActiveRecord::Base
  belongs_to  :user
  has_many    :issues
  
  ISSUE_TYPES = %w{software equipment computer peripheral network}
  STATUSES = ['open', 'in progress', 'pending customer response',
              'contact customer', 'closed']
  validates :title,         presence: true
  validates :issue_type,    presence: true,
                            inclusion: { in: ISSUE_TYPES }
  validates :status,        presence: true,
                            inclusion: { in: STATUSES }
  validates :priority,      presence: true,
                            numericality: { greater_than: 0,
                                            less_than: 6,
                                            only_integer: true }
end
