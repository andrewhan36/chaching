class CreateRecurringBills < ActiveRecord::Migration[5.1]
  def change
    create_table :recurring_bills do |t|
      t.string :bill_id
      t.datetime :start
      t.integer :interval_seconds

      t.timestamps
    end
  end
end
