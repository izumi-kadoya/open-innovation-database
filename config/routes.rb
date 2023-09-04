Rails.application.routes.draw do
  devise_for :users
  resources :records do
    member do
      get 'partner_details'
    end
  end
  root 'records#index'
end
