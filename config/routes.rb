require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users
  root to: 'top#show'
  resources :feeds
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  if Rails.env.development?
    mount Sidekiq::Web => '/w'
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
