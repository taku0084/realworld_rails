Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api do
    resources :users, only: [:create] do
      collection do
        post :login
      end
    end

    resource :user, only: [:show, :update]
  end
end
