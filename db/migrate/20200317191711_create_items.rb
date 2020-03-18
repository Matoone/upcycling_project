class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.belongs_to :category, optional: true, index: true
      t.belongs_to :shop, index: true

      t.integer :available_quantity
      t.float :price
      t.string :name
      t.text :description
      t.timestamps
    end
  end
end
