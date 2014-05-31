class ChangeEventTime < ActiveRecord::Migration
  def change
    remove_column :events, :expected_completion_time
    add_column :events, :open_till, :datetime
    add_column :events, :results_till, :datetime
  end
end
