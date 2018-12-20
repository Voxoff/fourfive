class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.references :product, foreign_key: true
      t.references :user, foreign_key: true
      t.string :position
      t.string :content
      t.string :photo
      t.string :name
      t.text :desc
      t.timestamps
    end
  end
end
