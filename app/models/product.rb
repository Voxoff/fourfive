class Product < ApplicationRecord
  self.table_name = "products"
  monetize :price_cents

  has_many :reviews
  belongs_to :product_group

  validates :name, :price, presence: true
  validates :size, inclusion: { in: %w[Small Large 500mg 1000mg 2000mg] }, allow_nil: true
  validates :tincture, inclusion: { in: %w[Natural Orange] }, allow_nil: true

  mount_uploader :photo, PhotoUploader

  def oil?
    name == "cbd_oils"
  end

  def balm?
    name == "cbd_balms"
  end

  def capsules?
    name == "cbd_capsules"
  end

  def revenue(count)
    count ? count * price : 0
  end

  def readable_name
    name.tr("_", " ")
  end

  def specific_name(with_oil = true)
    if oil?
      "#{tincture} #{size} #{with_oil ? oil : nil}"
    elsif balm?
      "#{size} balm" if balm?
    else
      "Capsules"
    end
  end

  def oil
    "oil"
  end

  def image_name
    if oil?
      change = { "500mg": "Lower", "1000mg": "Medium", "2000mg": "Higher"}
      "#{change[size.to_sym]} strength, #{tincture} flavour"
    elsif balm?
      "#{size} balm (30ml / 300mg)"
    else
      "Capsules"
    end
  end

  def how_to_use_text(&block)
    product_group.how_to_use.split("\n").each { |i| yield(i) if block_given? }
  end
end
