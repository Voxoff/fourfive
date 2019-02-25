FactoryBot.define do
  factory :cart_item do
    cart
    product
    quantity { 10 }
    factory :single_capsules_cart_item do
      cart
      # association :capsule_product, factory: :product
      quantity { 1 }
    end
  end
end
