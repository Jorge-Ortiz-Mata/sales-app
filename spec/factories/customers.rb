FactoryBot.define do
  factory :customer do
    trait :with_attributes do
      full_name { 'Jorge Ortiz' }
      phone_number { 1234567890 }
      address { 'San Luis Potosí S.L.P. México' }
    end
  end
end
