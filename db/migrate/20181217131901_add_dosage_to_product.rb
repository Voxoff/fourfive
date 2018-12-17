class AddDosageToProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :dosage, :string
  end
end
