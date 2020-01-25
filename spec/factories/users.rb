FactoryBot.define do
  factory :user do
    first_name { "John" }
    last_name { "Cena" }
    password { "password" }
    sequence(:email) { |n| "test#{n}@example.com" }

    trait :with_profile do
      after :create do |user|
        FactoryBot.create(:profile, user: user)
      end
    end
  end
end
