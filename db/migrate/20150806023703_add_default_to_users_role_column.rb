class AddDefaultToUsersRoleColumn < ActiveRecord::Migration
  def change
    change_column_default :users, :role, 'customer'
  end
end
