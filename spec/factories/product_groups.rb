FactoryBot.define do
  factory :product_group do

    factory :balm_product_group do
      name { "cbd_balms"}
    end

    factory :oil_product_group do
      name { "cbd_oils"}
    end

    factory :capsule_product_group do
      name { "cbd_capsules"}
    end
  end
end
