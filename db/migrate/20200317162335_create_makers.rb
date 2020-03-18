class CreateMakers < ActiveRecord::Migration[5.2]
  def change
    create_table :makers do |t|
      t.belongs_to :user, index: true
      t.string :first_name
      t.string :last_name
      t.text :description
      t.timestamps
    end
  end
end
