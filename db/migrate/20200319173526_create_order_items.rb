class CreateOrderItems < ActiveRecord::Migration[5.2]
  def change
    create_table :order_items do |t|
      t.decimal :buying_price
      t.integer :order_quantity
      t.belongs_to :order, index: true, foreign_key: true
      t.belongs_to :item, index: true, foreign_key: true
      t.timestamps
    end
  end
end
