class ProductProductGroupFk < ActiveRecord::Migration[5.2]
  def change
    add_reference :products, :product_group, foreign_key: true
  end
end
