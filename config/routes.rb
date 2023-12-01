Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
    } 
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  authenticated :user do
    root 'group_categories#index', as: :authenticated_root
  end

  unauthenticated do
    root 'splash#index', as: :unauthenticated_root
  end

  resources :group_categories, only: %i[index new show create] do
    resources :entity_categories, only: %i[index new create edit update destroy]
  end
end

