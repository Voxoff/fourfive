class Strength < ApplicationRecord
  has_many :product_strengths, dependent: :destroy
  has_many :products, through: :product_strengths
end
