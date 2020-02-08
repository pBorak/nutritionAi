FactoryBot.define do
  factory :profile do
    user
    sex { "male" }
    calorie_spread_ratio { [0.2, 0.3].sample }
    fat_ratio { rand(0.2..0.4).round(1) }
    protein_ratio { rand(2.0..2.6).round(1) }
    activity_level { rand(1..5) }
  end
end
