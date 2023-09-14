FactoryBot.define do
  factory :sell do
    trait :with_attributes do
      quantity { 3 }
      date_of_sell { '2023-09-09' }
    end

    trait :with_article do
      article { build(:article, :with_attributes, :with_stock) }
    end

    trait :with_more_quantity do
      quantity { 50 }
    end
  end
end
