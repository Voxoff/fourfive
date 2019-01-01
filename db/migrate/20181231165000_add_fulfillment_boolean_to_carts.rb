class AddFulfillmentBooleanToCarts < ActiveRecord::Migration[5.2]
  def change
    add_column :carts, :fulfillment, :boolean, default: false
  end
end
