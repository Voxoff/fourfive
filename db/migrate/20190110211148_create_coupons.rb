class CreateCoupons < ActiveRecord::Migration[5.2]
  def change
    create_table :coupons do |t|
      t.string :code
      t.boolean :active
      t.references :cart, foreign_key: true

      t.timestamps
    end
  end
end
