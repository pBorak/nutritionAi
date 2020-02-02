json.partial! "user", user: @sign_up_form.user
json.profile do
  json.extract!(
    @sign_up_form.profile,
    :id,
    :sex,
    :calorie_spread_ratio,
    :fat_ratio,
    :protein_ratio,
    :activity_level,
  )
end
