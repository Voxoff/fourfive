FactoryBot.define do
  factory :coupon do
    code { "mycode" }
    active { false }
    discount { 10 }
    factory :activated_coupon do
      active {true }
      code { "anothercode"}
    end
  end
end
