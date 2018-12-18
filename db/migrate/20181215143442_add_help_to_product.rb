class AddHelpToProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :help, :text, array: true, default: []
    add_column :products, :ingredients, :text, array: true, default: []
    add_column :products, :how_to_use, :text
    add_column :products, :size, :string
    add_column :products, :tincture, :string
    add_column :products, :dosage, :string
  end
end
