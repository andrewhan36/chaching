class CreatePayers < ActiveRecord::Migration[5.1]
  def change
    create_table :payers do |t|
      t.string :user_id
      t.string :gateway_account_id
      t.string :gateway_type

      t.timestamps
    end
  end
end
