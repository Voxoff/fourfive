class Product < ApplicationRecord
  self.table_name = "products"
  monetize :price_cents

  has_many :reviews
  has_many :product_strengths, dependent: :destroy
  has_many :strengths, through: :product_strengths


  validates :name, :price, presence: true
  validates :size, inclusion: { in: %w[small large 500mg 1000mg 2000mg] }, allow_nil: true
  validates :tincture, inclusion: { in: %w[natural orange] }, allow_nil: true
  validates :dosage, inclusion: { in: %w[spray pipette] }, allow_nil: true

  mount_uploader :photo, PhotoUploader

  extend FriendlyId
  friendly_id :name

  def oil?
    name == "cbd oils"
  end

  def balm?
    name == "cbd balms"
  end
end
