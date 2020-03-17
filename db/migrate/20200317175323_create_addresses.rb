class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.belongs_to :maker, optional: true
      t.belongs_to :customer, optional: true
      t.string :street_number
      t.string :address_line_1
      t.string :address_line_2
      t.string :zip_code
      t.string :city
      t.timestamps
    end
  end
end
