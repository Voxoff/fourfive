FactoryBot.define do
  factory :cart do
    coupon { "Team45"}
    # cart_item

      after(:create) do |cart|
        # create(:cart_item, 1, cart: cart)
        cart.cart_items << create_list(:cart_item, 2, cart: cart)
      end
  end
end
