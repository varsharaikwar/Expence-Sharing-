Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'users#index'
  resources :groups do
    resources :users, except: [:index] do
      resources :debts, except: [:new, :edit]
    end

    resources :expenses, except: [:index]
  end

  get '/users/:id/groups', to: 'users#groups', as: 'user_groups'

  delete '/groups/:group_id/users/:id/debts/delete', to: 'debts#settle', as: 'group_user_debts_delete'

  resources :invites

end
