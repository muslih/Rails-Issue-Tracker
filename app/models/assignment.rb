class Assignment < ActiveRecord::Base
  belongs_to :ticket
  belongs_to :group
end
