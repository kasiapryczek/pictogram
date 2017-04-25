Rails.application.routes.draw do
  get 'profiles/show'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :posts do
    resources :comments
    member do
      get 'like'
    end
  end
  root 'posts#index'

  get ':name', to: 'profiles#show', as: :profile
  get ':name/edit', to: 'profiles#edit', as: :edit_profile
  patch ':name/edit', to: 'profiles#update', as: :update_profile

end
