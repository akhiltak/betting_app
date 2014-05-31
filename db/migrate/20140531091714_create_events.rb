class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.string :desc
      t.string :category
      t.date :expected_completion_time
      t.integer :total_bets

      t.timestamps
    end
  end
end
