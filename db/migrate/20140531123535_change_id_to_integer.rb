class ChangeIdToInteger < ActiveRecord::Migration
  def up
    change_column :bets, :event_id, :integer
    change_column :bets, :outcome_id, :integer
    change_column :bets, :user_id, :integer
    change_column :outcomes, :event_id, :integer
  end

  def down
  end
end
