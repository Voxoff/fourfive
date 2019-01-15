class RemoveInteractivePhotoToProductGroup < ActiveRecord::Migration[5.2]
  def change
    remove_column :product_groups, :interactive_photo
  end
end
