class AddSubtitleToProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :subtitle, :string
  end
end
