Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'expenses#index'
  resources :groups do
    resources :users, except: [:index] do
      resources :debts, except: [:new]
    end

    resources :expenses, except: [:index]
  end


end
