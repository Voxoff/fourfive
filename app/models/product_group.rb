class ProductGroup < ApplicationRecord
  mount_uploader :photo, PhotoUploader

  has_many :products

  def readable_name
    name.gsub("_", " ")
  end
end
