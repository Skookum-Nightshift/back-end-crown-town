Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # API
  namespace :api, defaults: {format: :json} do
    devise_for :users, skip: [:registrations]

    namespace :v1 do
      post "/sign_in", to: "sessions#login" #localhost:3000/api/v1/sign_in
      resource :sign_up, only: [:create], controller: :registrations #localhost:3000/api/v1/sign_up

      scope :users do #localhost:3000/api/v1/users
        get "/", to: "users#route_index"
        post "/", to: "users#update"
        post "/password", to: "users#update_password"
        post "/cancel_pickup", to: "users#cancel_pickup"
        post "/update_bucket_location", to: "users#update_bucket_location"
      end

      scope :neighborhoods do #localhost:3000/api/v1/neighborhoods
        get "/", to: "neighborhoods#index"
        get "/needs_pick_up", to: "neighborhoods#needs_pick_up"
      end

      scope :locations do #localhost:3000/api/v1/locations
        get "/next", to: "locations#next"
      end
    end

    get "*any", to: "pages#not_found"
  end

  root "pages#not_found"

  get "*any", to: "pages#not_found"

end
