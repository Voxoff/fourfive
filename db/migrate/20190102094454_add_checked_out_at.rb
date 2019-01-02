class AddCheckedOutAt < ActiveRecord::Migration[5.2]
  def change
    add_column :carts, :checked_out_at, :datetime
  end
end
