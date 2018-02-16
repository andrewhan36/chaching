class CreatePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :payments do |t|
      t.string :uuid
      t.string :bill_uuid
  	  t.string :gateway_payment_id
  	  t.string :gateway
      t.timestamps
    end
  end
end
