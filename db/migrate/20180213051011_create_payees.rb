class CreatePayees < ActiveRecord::Migration[5.1]
  def change
    create_table :payees do |t|
      t.string :uuid
      t.string :merchant_uuid
      t.string :gateway_token
      t.string :gateway_type

      t.timestamps
    end
  end
end
