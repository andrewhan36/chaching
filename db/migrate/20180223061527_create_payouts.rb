class CreatePayouts < ActiveRecord::Migration[5.1]
  def change
    create_table :payouts do |t|
      t.string :uuid
      t.string :payee_uuid
      t.float :amount
      t.string :currency
      
      t.timestamps
    end
  end
end
