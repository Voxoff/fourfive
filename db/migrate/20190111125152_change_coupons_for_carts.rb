class ChangeCouponsForCarts < ActiveRecord::Migration[5.2]
  def change
    remove_column :carts, :coupon, :string
    add_reference :carts, :coupon, foreign_key: true
  end
end
