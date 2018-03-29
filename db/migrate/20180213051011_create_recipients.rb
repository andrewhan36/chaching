class CreateRecipients < ActiveRecord::Migration[5.1]
  def change
    create_table :recipients do |t|
      t.string :user_id
      t.string :gateway_account_id
      t.string :gateway_type

      t.timestamps
    end
  end
end
