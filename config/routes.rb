Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :bookings, except: %i[index show]
end
