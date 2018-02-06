class CreatePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :payments do |t|
      t.string :uuid
      t.string :bill_uuid
      t.timestamps
    end
  end
end
