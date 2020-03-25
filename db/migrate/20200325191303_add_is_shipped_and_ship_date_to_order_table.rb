class AddIsShippedAndShipDateToOrderTable < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :is_shipped, :boolean, default: false
    add_column :orders, :ship_date, :datetime
  end
end
