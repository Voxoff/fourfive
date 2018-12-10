class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :sku
      t.string :name
      t.string :description
      t.boolean :availability
      t.integer :strength
      t.string :photo
      t.string :subtitle

      t.timestamps
    end
  end
end
