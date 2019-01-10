FactoryBot.define do
  factory :coupon do
    code { "MyString" }
    active { false }
    cart { nil }
  end
end
