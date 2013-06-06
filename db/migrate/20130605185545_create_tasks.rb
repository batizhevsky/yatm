class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.date :deadline
      t.integer :user_id
      t.integer :responsible_id

      t.timestamps
    end
  end
end
