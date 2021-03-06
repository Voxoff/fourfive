class Address < ApplicationRecord
  belongs_to :cart
  # validates :postcode, presence: true, format: { with: /([Gg][Ii][Rr] 0[Aa]{2})|((([A-Za-z][0-9]{1,2})|(([A-Za-z][A-Ha-hJ-Yj-y][0-9]{1,2})|(([A-Za-z][0-9][A-Za-z])|([A-Za-z][A-Ha-hJ-Yj-y][0-9][A-Za-z]?))))\s?[0-9][A-Za-z]{2})/}
  # validates :activated_at, :presence, if: Proc.new { |a| a.is_activated? }
  validates :first_line, :city, presence: true
  # validates :phone_number, presence: true, format: { with: /^\+?(?:\d\s?){10,12}$/}
  validates :city, presence: true
  validates :salutation, inclusion: { in: %w[Mr Mrs Ms Miss] }, allow_nil: true
  validates :email, presence: true
  validates :country, inclusion: { in: %w[UK UKNI IRE IE] }, allow_nil: true
  # after_validation { postcode.upcase! }

  def get_address
    [first_line, second_line, postcode, city]
  end

  def duplicate?(user)
    user_addrs = user.addresses.map(&:get_address)
    user_addrs << get_address
    user_addrs.count != user_addrs.uniq.count
  end

  def full_address
    addr = nice_print([first_line, second_line, third_line, city, postcode])
    add_country(addr)
  end

  def add_country(addr)
    country ? nice_print([addr, convert_country]) : addr
  end

  def convert_country
    country == "UK" ? "UK" : self.class.countries[country.to_sym]
  end

  def full_name
    "#{first_name} #{last_name}".titleize
  end

  def city_and_postcode
    nice_print([city, postcode])
  end

  def full_name_with_salutation
    salutation.present? ? "#{salutation}. #{full_name}" : full_name.to_s
  end

  def self.countries
    { UK: "United Kingdom (Eng, Sco, Wal)", UKNI: "United Kingdom (NI)", IRE: "Ireland" }
  end

  private

  def nice_print(input)
    input.select(&:present?).join(", ")
  end
end
