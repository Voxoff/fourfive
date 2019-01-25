class CreateCoupons < ActiveRecord::Migration[5.2]
  def change
    create_table :coupons do |t|
      t.string :code
      t.boolean :active
      t.integer :discount

      t.timestamps
    end
  end
end
