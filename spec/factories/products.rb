FactoryBot.define do
  factory :product do
    association :product_group, factory: :product_group

    name { "cbd_balms" }
    price { 29.99 }
    factory :balm_product do
      association :product_group, factory: :oil_product_group
      size { "Small"}
    end

    factory :oil_product do
      name { "cbd_oils"}
      tincture { "Natural"}
      size { "500mg"}
      price { 29.99 }
    end

    factory :capsule_product do
      name { "cbd_capsules"}
      price { 39.99 }
    end
  end
end
