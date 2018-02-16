Rails.application.routes.draw do
  get 'home/index'

  get 'payments', to: 'payment_action#index'
  post 'payments', to: 'payment_action#create'
  post 'payments/approve', to: 'payment_action#approve'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'
end
