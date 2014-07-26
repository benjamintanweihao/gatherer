class AddTitleAndSizeAndCompletedAtToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :title, :string
    add_column :tasks, :size, :integer
    add_column :tasks, :completed_at, :datetime
  end
end
