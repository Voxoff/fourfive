FactoryBot.define do
  factory :cart_item do
    product
    quantity { 10 }
  end
end
