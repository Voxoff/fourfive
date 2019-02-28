FactoryBot.define do
  factory :cart do
    order_id { 1 }
    after(:create) do |cart|
      cart.cart_items << create_list(:cart_item, 2, cart: cart)
      cart.address ||= FactoryBot.create(:address, cart: cart)
    end
  end
end
