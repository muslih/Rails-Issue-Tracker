class Ticket < ActiveRecord::Base
  belongs_to  :user
  has_many    :issues
  accepts_nested_attributes_for :issues
  
  ISSUE_TYPES = %w{software equipment computer peripheral network}
  STATUSES = ['open', 'in progress', 'pending customer response',
              'customer responded', 'contact customer', 'closed']
  validates :title,         presence: true
  validates :issue_type,    presence: true,
                            inclusion: { in: ISSUE_TYPES }
  validates :status,        presence: true,
                            inclusion: { in: STATUSES }
  validates :priority,      presence: true,
                            numericality: { greater_than: 0,
                                            less_than: 6,
                                            only_integer: true }

  def self.search(search)
    if search
      where("title LIKE ?", "%#{search}%")
      # joins(:user).where('title LIKE ? OR users.first_name LIKE ? OR users.last_name LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%")
      joins(:user).where("title LIKE ? OR (printf('%s %s', users.first_name, users.last_name) LIKE ?)", 
                         "%#{search}%", "%#{search}%")
    else
      find(:all)
    end
  end
end
