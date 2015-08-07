class RemoveTicketRelationshipFromGroupMeMberships < ActiveRecord::Migration
  def change
    remove_column :group_memberships, :ticket_id
  end
end
