class AddTermsBooleansToCart < ActiveRecord::Migration[5.2]
  def change
    add_column :carts, :terms, :boolean
  end
end
