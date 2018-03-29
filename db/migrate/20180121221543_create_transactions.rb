class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.string :payer_id
  	  t.string :recipient_id
  	  t.string :bill_id
  	  t.string :gateway_transaction_id
  	  t.string :gateway_type
      t.timestamps
    end
  end
end
