class CreateBills < ActiveRecord::Migration[5.1]
  def change
    create_table :bills do |t|
      t.string :uuid
      t.string :bill_type
      t.string :creator_uuid
      t.string :payer_uuid
      t.string :payee_uuid
      t.datetime :payment_due
      t.float :amount
      t.string :currency
      t.string :status
      t.string :payment_uuid

      t.timestamps
    end
  end
end
