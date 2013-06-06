class AddStateToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :state, :string
    Task.update_all(state: "opened")
  end
end
