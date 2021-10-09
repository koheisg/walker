require 'sidekiq/web'

Sidekiq::Web.use Rack::Auth::Basic do |username, password|
  username == ENV['ADMIN_USER'] && password == ENV['ADMIN_PASSWORD']
end

Rails.application.routes.draw do
  root to: 'top#show'
  resource :session, only: [:new, :create, :destroy]
  get :home, to: 'home#show'
  resources :feeds do
    resources :items, module: 'feeds', only: [:index] do
      collection do
        resources :daily, param: :date, module: 'items', only: :show
      end
    end
  end
  mount Sidekiq::Web => '/w'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
