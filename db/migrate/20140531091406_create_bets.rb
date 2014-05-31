class CreateBets < ActiveRecord::Migration
  def change
    create_table :bets do |t|
      t.string :user_id
      t.integer :bet_amount
      t.string :event_id
      t.string :outcome_id

      t.timestamps
    end
  end
end
