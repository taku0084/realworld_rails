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
      member do
        post :favorite
        delete :favorite, action: :unfavorite
      end

      resources :comments, only: [:index, :create] do
      end
    end
  end
end
