class AddDefaultStatusToTasks < ActiveRecord::Migration[7.0]
  def change
    change_column_default :tasks, :status, "todo"
  end
end
