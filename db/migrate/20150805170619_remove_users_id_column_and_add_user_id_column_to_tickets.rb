class RemoveUsersIdColumnAndAddUserIdColumnToTickets < ActiveRecord::Migration
  def change
    remove_column :tickets, :users_id
    add_column :tickets, :user_id, :integer
  end
end
