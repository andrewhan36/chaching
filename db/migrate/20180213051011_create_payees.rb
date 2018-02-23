class CreatePayees < ActiveRecord::Migration[5.1]
  def change
    create_table :payees do |t|
      t.string :uuid
      t.string :merchant_uuid
      t.string :payin_gateway_token
      t.string :payin_gateway_type
      t.string :payout_gateway_token
      t.string :payout_gateway_type
      t.datetime :next_payout

      t.timestamps
    end
  end
end
