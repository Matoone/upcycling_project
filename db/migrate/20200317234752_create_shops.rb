class CreateShops < ActiveRecord::Migration[5.2]
  def change
    create_table :shops do |t|
      t.belongs_to :maker, index: true
      t.timestamps
    end
  end
end
