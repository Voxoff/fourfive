class Review < ApplicationRecord
  belongs_to :product
  belongs_to :user
  validates :name, presence: true
  mount_uploader :photo, PhotoUploader
end
