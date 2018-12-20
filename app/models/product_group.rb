class ProductGroup < ApplicationRecord
  mount_uploader :photo, PhotoUploader

  has_many :products, dependent: :destroy

  def readable_name
    name.gsub("_", " ")
  end
end
