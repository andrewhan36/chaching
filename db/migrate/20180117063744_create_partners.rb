class CreatePartners < ActiveRecord::Migration[5.1]
  def change
    create_table :partners do |t|
      t.string :name
      t.string :country
      t.string :uuid
      t.timestamps
    end
  end
end
