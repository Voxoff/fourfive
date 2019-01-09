class AddReciptToCart < ActiveRecord::Migration[5.2]
  def change
    add_column :carts, :receipt, :string
  end
end
