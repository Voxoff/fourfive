class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :first_line
      t.string :second_line
      t.string :postcode
      t.string :phone_number
      t.string :city
      t.string :email
      t.references :user, foreign_key: true
      t.references :cart, foreign_key: true

      t.timestamps
    end
  end
end
