# filepath: /Users/akram.abdelnasser/Documents/private/events_booking/config/routes.rb
Rails.application.routes.draw do
  devise_for :users

  resources :events do
    resources :bookings
  end

  root "events#index"
end