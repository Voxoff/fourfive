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

  def capsules?
    name == "cbd_capsules"
  end


  def readable_name
    name.gsub("_", " ")
  end

  def specific_name
    if oil?
      "#{tincture} #{size} oil"
    elsif balm?
      "#{size} balm" if balm?
    else
      "Capsules"
    end
  end

  def image_name
    if oil?
      change = {"500mg": "Lower", "1000mg": "Medium", "2000mg": "Higher"}
      "#{change[size.to_sym]} strength, #{tincture} flavour"
    elsif balm?
      "#{size} balm"
    else
      "Capsules"
    end

  end
end
