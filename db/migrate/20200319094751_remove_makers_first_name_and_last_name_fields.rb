class RemoveMakersFirstNameAndLastNameFields < ActiveRecord::Migration[5.2]
  def change
    remove_column :makers, :first_name, :string
    remove_column :makers, :last_name, :string
  end
end
