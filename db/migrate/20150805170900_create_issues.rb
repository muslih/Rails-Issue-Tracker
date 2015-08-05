class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.references :ticket
      t.text       :description
      t.timestamps null: false
    end
  end
end
