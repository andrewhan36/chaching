class CreateRecurringBills < ActiveRecord::Migration[5.1]
  def change
    create_table :recurring_bills do |t|
      t.string :uuid
      t.string :bill_uuid
      t.datetime :trigger_datetime
      t.integer :creation_interval_seconds

      t.timestamps
    end
  end
end
