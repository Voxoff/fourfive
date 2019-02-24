class ProductGroup < ApplicationRecord
  mount_uploader :photo, PhotoUploader

  has_many :products, dependent: :destroy

  def self.oil?(oil = true)
    hash = { name: "cbd_oils" }
    oil ?  where(hash) : where.not(hash)
  end

  def readable_name
    name.tr("_", " ")
  end

  def group_name
    name.split("_").last
  end

  def interactive_photo_slug
    group_name + "_interactive.jpg"
  end
end
