class Address < ApplicationRecord
  belongs_to :cart
  validates :postcode, presence: true, format: { with: /([Gg][Ii][Rr] 0[Aa]{2})|((([A-Za-z][0-9]{1,2})|(([A-Za-z][A-Ha-hJ-Yj-y][0-9]{1,2})|(([A-Za-z][0-9][A-Za-z])|([A-Za-z][A-Ha-hJ-Yj-y][0-9][A-Za-z]?))))\s?[0-9][A-Za-z]{2})/}
  validates :first_line, :city, presence: true
  validates :phone_number, numericality: { integer: true }
  # validates :city, presence: true
  validates :salutation, inclusion: { in: %w[Mr Mrs Ms Miss] }, allow_nil: true

  def get_address
    [first_line, second_line, postcode, city]
  end

  def duplicate?(user)
    user_addrs = user.addresses.map(&:get_address)
    user_addrs << get_address
    user_addrs.count != user_addrs.uniq.count
  end

  def full_address
    nice_print([first_line, second_line, third_line, city, postcode])
  end

  def full_name
    nice_print([first_name, last_name])
  end

  def city_and_postcode
    nice_print([city, postcode])
  end

  private

  def nice_print(input)
    input.select(&:present?).join(", ")
  end
end
