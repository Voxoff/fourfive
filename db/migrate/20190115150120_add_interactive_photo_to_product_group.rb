class AddInteractivePhotoToProductGroup < ActiveRecord::Migration[5.2]
  def change
    add_column :product_groups, :interactive_photo_slug, :string
  end
end
