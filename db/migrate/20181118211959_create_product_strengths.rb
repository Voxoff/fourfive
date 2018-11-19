class CreateProductStrengths < ActiveRecord::Migration[5.2]
  def change
    create_table :product_strengths do |t|
      t.references :product, foreign_key: true
      t.references :strength, foreign_key: true

      t.timestamps
    end
  end
end
