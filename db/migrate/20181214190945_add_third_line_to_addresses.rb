class AddThirdLineToAddresses < ActiveRecord::Migration[5.2]
  def change
    add_column :addresses, :third_line, :string
  end
end
