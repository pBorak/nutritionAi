require "sidekiq/web"

Rails.application.routes.draw do
  mount Sidekiq::Web, at: "/admin/sidekiq"

  namespace :api, constraints: { format: "json" } do
    namespace :v1 do
      post "user_token" => "user_token#create"
      resource :users
    end
  end
end
