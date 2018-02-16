class CreatePayers < ActiveRecord::Migration[5.1]
  def change
    create_table :payers do |t|
      t.string :uuid
      t.string :user_uuid
      t.string :gateway_token
      t.string :gateway_type

      t.timestamps
    end
  end
end
