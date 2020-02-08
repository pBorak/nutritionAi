json.extract! profile, :id, :sex
json.calorie_spread_ratio profile.calorie_spread_ratio.round(1)
json.fat_ratio profile.fat_ratio.round(1)
json.protein_ratio profile.protein_ratio.round(1)
json.activity_level profile.activity_level
