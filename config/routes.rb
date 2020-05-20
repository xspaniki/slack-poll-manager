Rails.application.routes.draw do
  resources :polls, only: [:index, :show, :new, :create]

  namespace :api do
    namespace :v1 do
      resources :votes, only: [:create]
    end
  end

  match "/" => redirect("/polls"), via: :all
  match "/*path" => redirect("/polls"), via: :all
end
