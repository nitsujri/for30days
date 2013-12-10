class CreateTaskLogs < ActiveRecord::Migration
  def change
    create_table :task_logs do |t|
      t.integer :task_id
      t.integer :user_id
      t.string  :status

      t.timestamps
    end

    add_index :task_logs, :task_id
    add_index :task_logs, :user_id
  end
end
