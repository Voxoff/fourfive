class Product < ApplicationRecord
  self.table_name = "products"
  monetize :price_cents

  has_many :reviews

  validates :name, :price, presence: true
  validates :size, inclusion: { in: %w[Small Large 500mg 1000mg 2000mg] }, allow_nil: true
  validates :tincture, inclusion: { in: %w[Natural Orange] }, allow_nil: true

  mount_uploader :photo, PhotoUploader

  belongs_to :product_group

  extend FriendlyId
  friendly_id :name

  def oil?
    name == "cbd_oils"
  end

  def balm?
    name == "cbd_balms"
  end

  def readable_name
    name.gsub("_", " ")
  end

  def specific_name
    if oil?
    "#{tincture} #{size} oil"
    elsif balm?
    "#{size}" if balm?
    else
      "Capsules"
    end
  end
end
