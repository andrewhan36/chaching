Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'main#test'

  scope '/1.0' do
  	get '/bill/:id', to: 'main#bill', as: 'bill'
    get '/payer/:id', to: 'main#payer', as: 'payer'
    get '/recipient/:id', to: 'main#recipient', as: 'recipient'
    get '/recurring_bill/:id', to: 'main#recurring_bill', as: 'recurring_bill'
    get '/transaction/:id', to: 'main#transaction', as: 'transaction'

    get '/bill', to: 'main#bill_list', as: 'bill_list'
    get '/payer', to: 'main#payer_list', as: 'payer_list'
    get '/recipient', to: 'main#recipient_list', as: 'recipient_list'
    get '/recurring_bill', to: 'main#recurring_bill_list', as: 'recurring_bill_list'
    get '/transaction', to: 'main#transaction_list', as: 'transaction_list'

    # post '/bill', to: 'main#create_bill', as: 'create_bill'
    post '/payer', to: 'main#create_payer', as: 'create_payer'
    post '/recipient', to: 'main#create_recipient', as: 'create_recipient'
    post '/recipient/:user_id/external_account', to: 'main#add_recipient_payout', as: 'add_recipient_payout'
    # post '/recurring_bill', to: 'main#create_recurring_bill', as: 'create_recurring_bill'
    post '/transaction', to: 'main#create_transaction', as: 'create_transaction'
  end
end
