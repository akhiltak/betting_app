class AddEventFinalOutcome < ActiveRecord::Migration
  def change
    remove_column :events, :results_till
    add_column :events, :status, :string
    add_column :events, :final_outcome_id, :integer
  end
end
