class RemoveUserTypeColumnAndAddRoleColumnToUsers < ActiveRecord::Migration
  def change
    remove_column :users, :user_type
    add_column :users, :role, :string
  end
end
