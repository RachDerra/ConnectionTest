Rails.application.routes.draw do
  root "posts#index"
 # get '/', to: 'posts#index'

 resources :users, only: [:new, :create, :show]

 resources :sessions, only: [:new, :create, :destroy]

  resources :posts do
    collection do
      post :confirm
    end
  end
end
