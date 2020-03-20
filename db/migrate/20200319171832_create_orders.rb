class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :stripe_customer_id
      t.belongs_to :shop, index: true, foreign_key: true
      t.belongs_to :customer, index: true, foreign_key: true
      t.timestamps
    end
  end
end
