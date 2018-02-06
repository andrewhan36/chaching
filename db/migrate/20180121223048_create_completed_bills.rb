class CreateCompletedBills < ActiveRecord::Migration[5.1]
  def change
    create_table :completed_bills do |t|
      t.float :amount_cents
      t.string :amount_currency
      t.string :payement_uuid
      t.string :title
      t.string :description
      t.datetime :payment_date

      t.timestamps
    end
  end
end
