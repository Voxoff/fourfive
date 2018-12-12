class Address < ApplicationRecord
  belongs_to :cart
  validates :postcode, presence: true, format: { with: /([Gg][Ii][Rr] 0[Aa]{2})|((([A-Za-z][0-9]{1,2})|(([A-Za-z][A-Ha-hJ-Yj-y][0-9]{1,2})|(([A-Za-z][0-9][A-Za-z])|([A-Za-z][A-Ha-hJ-Yj-y][0-9][A-Za-z]?))))\s?[0-9][A-Za-z]{2})/}
  validates :first_line, presence: true
  # validates :phone_number, presence: true, numericality: {integer: true}
  validates :city, presence: true

  def get_address
    [self.first_line, self.second_line, self.postcode, self.city]
  end

  def duplicate?(user)
    user_addrs = user.addresses.map(&:get_address)
    user_addrs << self.get_address
    user_addrs.count != user_addrs.uniq.count
  end

  def full_address
    "#{self.first_line}, #{self.second_line}, #{self.city}, #{self.postcode} "
  end
end
