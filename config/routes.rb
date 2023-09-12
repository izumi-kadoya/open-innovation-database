Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:index, :update, :destroy]
  resources :records do
    member do
      get 'partner_details'
    end
    collection do
      get 'filter_by_industry'
      get 'download'
      get 'download_page'  
    end
  end
  
  root 'records#index'
end
