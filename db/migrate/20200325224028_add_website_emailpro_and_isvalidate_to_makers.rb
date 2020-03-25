class AddWebsiteEmailproAndIsvalidateToMakers < ActiveRecord::Migration[5.2]
  def change
    add_column :makers, :email_pro, :string
    add_column :makers, :website, :string
    add_column :makers, :is_validated?, :boolean, default: false
  end
end
