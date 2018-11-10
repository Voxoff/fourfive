class AddStrengthToCartItem < ActiveRecord::Migration[5.2]
  def change
    add_column :cart_items, :strength, :integer
  end
end
