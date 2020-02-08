json.partial! "user", user: @sign_up_form.user
json.profile do
  json.partial! "api/v1/profiles/profile", profile: @sign_up_form.profile
end
