Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'users#index'
  resources :groups do
    resources :users, except: [:index] do
      resources :debts, except: [:new, :edit]
    end

    resources :expenses, except: [:index]
  end

  get '/users/:id/groups', to: 'users#groups', as: 'user_groups'

  resources :invites

end
