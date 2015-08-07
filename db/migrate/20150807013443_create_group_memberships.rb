class CreateGroupMemberships < ActiveRecord::Migration
  def change
    create_table :group_memberships do |t|
      t.integer :user_id
      t.integer :ticket_id
      t.integer :group_id
      t.string  :role
      t.string  :group_name
      
      t.timestamps null: false
    end
  end
end
