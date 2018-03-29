class CreateBills < ActiveRecord::Migration[5.1]
  def change
    create_table :bills do |t|
      t.string :bill_type
      t.string :creator_id
      t.string :payer_id
      t.string :recipient_id
      t.float :amount
      t.string :currency
      t.string :status
      t.string :notes
      t.datetime :completion_deadline

      t.timestamps
    end
  end
end
