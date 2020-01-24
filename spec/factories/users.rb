FactoryBot.define do
  factory :user do
    first_name { "John" }
    last_name { "Cena" }
    password { "password" }
    sequence(:email) { |n| "test#{n}@example.com" }
  end
end
