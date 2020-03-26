class RemoveStreetNumberColumnFromAddressesTable < ActiveRecord::Migration[5.2]
  def change
    remove_column :addresses, :street_number, :string
  end
end
