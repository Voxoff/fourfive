FactoryBot.define do
  factory :address do
    cart
    first_line { "24 Orkney House" }

    trait :second_line do
      second_line { "199 Caledonian Road" }
    end

    trait :third_line do
      second_line { "Bemerton Estate" }
    end

    postcode { "N10AF" }
    city { "London" }

    email { "guy@fourfivecbd.co.uk" }
  end
end
