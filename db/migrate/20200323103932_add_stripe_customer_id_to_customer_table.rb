class AddStripeCustomerIdToCustomerTable < ActiveRecord::Migration[5.2]
  def change
    add_column :customer, :stripe_customer_id, :string
  end
end
