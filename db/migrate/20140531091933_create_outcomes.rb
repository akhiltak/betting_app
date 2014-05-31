class CreateOutcomes < ActiveRecord::Migration
  def change
    create_table :outcomes do |t|
      t.string :outcome_name
      t.string :event_id
      t.string :odds
      t.integer :number_of_bets
      t.string :odds_display_text

      t.timestamps
    end
  end
end
