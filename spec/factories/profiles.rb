FactoryBot.define do
  factory :profile do
    user
    sex { "male" }
    calorie_spread_ratio { rand(0.2..0.3) }
    fat_ratio { rand(0.2..0.4) }
    protein_ratio { rand(2.0..2.6) }
    activity_level { rand(1..5) }
  end
end
