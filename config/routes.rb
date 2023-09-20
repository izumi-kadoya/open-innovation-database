Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:index, :update, :destroy]
  resources :records do
    member do
      get 'partner_details'
      post 'save_article_summary'
      post 'access_openai_description'
      post 'save_business_description'
    end
    collection do
      post 'access_openai_summary' 
      post 'text_to_speech'
      get 'filter_by_industry'
      get 'download'
      get 'download_page'  
    end
  end
  
  root 'records#index'
end
