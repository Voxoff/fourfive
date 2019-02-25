FactoryBot.define do
  factory :cart do
    after(:create) do |cart|
      cart.cart_items << create_list(:cart_item, 2, cart: cart)
    end
  end
end
