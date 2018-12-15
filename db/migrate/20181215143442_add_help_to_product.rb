class AddHelpToProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :help, :text, array: true, default: []
    add_column :products, :ingredients, :text, array: true, default: []
    add_column :products, :how_to_use, :text

  end
end
