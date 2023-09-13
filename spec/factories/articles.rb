FactoryBot.define do
  factory :article do
    trait :with_attributes do
      name { 'Play Station 5' }
      description { 'Short description about this article' }
      price { 399.49 }
    end

    trait :with_stock do
      in_stock { 15 }
    end

    trait :without_stock do
      in_stock { 0 }
    end
  end
end
