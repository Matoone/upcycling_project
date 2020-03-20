class AddIsArchivedColumToItemsTable < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :is_archived, :boolean, default: false
  end
end
