require 'sidekiq/web'

Sidekiq::Web.use Rack::Auth::Basic do |username, password|
  username == ENV['ADMIN_USER'] && password == ENV['ADMIN_PASSWORD']
end

Rails.application.routes.draw do
  root to: 'top#show'
  get :home, to: 'home#show'
  resource :session, only: [:new, :create, :destroy]
  resources :feeds do
    resources :items, module: 'feeds', only: [:index] do
      collection do
        resources :daily, param: :date, module: 'items', only: :show
        resources :weekly, param: :date, module: 'items', only: :show
      end
    end
  end
  resources :feed_groups do
    resources :items, module: 'feed_groups', only: [:index] do
      collection do
        resources :daily, param: :date, module: 'items', only: :show
        resources :weekly, param: :date, module: 'items', only: :show
        resources :feeds, module: 'feeds' do
          resources :daily, param: :date, module: 'items', only: :show
          resources :weekly, param: :date, module: 'items', only: :show
        end
      end
    end
  end
  mount Sidekiq::Web => '/w'
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
