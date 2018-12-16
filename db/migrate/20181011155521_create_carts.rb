class CreateCarts < ActiveRecord::Migration[5.2]
  def change
    create_table :carts do |t|
      t.references :user, foreign_key: true
      t.string :coupon
      # t.string :status, default: "active"
      t.boolean :active, default: true
      t.timestamps
    end
  end
end
