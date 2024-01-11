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

    resources :articles, only: [:index, :create, :show, :update] do
      collection do
        get :feed
      end

      resource :favorite, only: [:create, :destroy]

      resources :comments, only: [:index, :create] do
      end
    end

    resources :profiles, only: [:show] do
      resource :follow, only: [:create, :destroy]
    end

    resources :tags, only: [:index]
  end
end
