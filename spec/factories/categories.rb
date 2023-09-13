FactoryBot.define do
  factory :category do
    trait :with_attributes do
      name { 'Sports' }
    end
  end
end
