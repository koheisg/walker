require 'sidekiq/web'

Rails.application.routes.draw do
  resource :session
  root to: 'top#show'
  resource :session
  resources :feeds do
    resources :items, module: 'feeds', only: [:index] do
      collection do
        resources :daily, param: :date, module: 'feeds/items', only: :show
      end
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  if Rails.env.development?
    mount Sidekiq::Web => '/w'
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
