class CreateProductGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :product_groups do |t|
      t.text :help, array: true, default: []
      t.text :ingredients, array: true, default: []
      t.text :how_to_use
      t.text :description
      t.string :subtitle
      t.string :photo
      t.string :name

      t.timestamps
    end
  end
end
