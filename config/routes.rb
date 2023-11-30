Rails.application.routes.draw do
  # devise_for :add_devise_to_users
  # get 'splash_screen/index'
  # get 'entity_categories/new'
  # get 'group_categories/index'
  # get 'group_categories/show'
  # get 'group_categories/new'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  authenticated :user do
    root 'group_categories#index', as: :authenticated_root
  end

  unauthenticated do
    root 'splash_screen#index', as: :unauthenticated_root
  end

  resources :group_categories, only: %i[index new show create update edit destroy] do
    resources :entity_categories, only: %i[index new create edit update destroy]
  end
end
