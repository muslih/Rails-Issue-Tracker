class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.references    :users
      t.string        :title
      t.string        :issue_type
      t.string        :status
      t.timestamps null: false
    end

    add_index :tickets, :title
    add_index :tickets, :issue_type
  end
end
