class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.integer :credits
      t.string :device_id

      t.timestamps
    end
  end
end
