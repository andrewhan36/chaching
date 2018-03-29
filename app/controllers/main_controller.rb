class MainController < ApplicationController
  include StripeHelper
  
  def payer
  	@response = Payer.where(user_id: params[:id])
  	render "index"
  end

  def recipient
    @response = Recipient.where(user_id: params[:id])
    render "index"
  end

  def transaction
    @response = Transaction.where(id: params[:id])
    render "index"
  end

  def bill
    @response = Bill.where(id: params[:id])
    render "index"
  end

  def recurring_bill
    @response = "recurring_bill"
    render "index"
  end

  def payer_list
    @response = Payer.all
    render "index"
  end

  def recipient_list
    @response = Recipient.all
    render "index"
  end

  def transaction_list
    @response = Transaction.all
    render "index"
  end

  def bill_list
    @response = Bill.all
    render "index"
  end

  def recurring_bill_list
    @response = "recurring_bill"
    render "index"
  end

  def create_payer
    verify_idempotence params[:request_token]
  	if Payer.exists?(:user_id => params[:id])
  		@response = Payer.where(user_id: params[:id])
  	else
  		# stripe_account = create_stripe_customer
  		@response = Payer.create(
  		user_id: params[:id], 
  		gateway_account_id: "stripe_account.id", 
  		gateway_type: "stripe")
  	end
  	render "index"
  end

  def create_recipient
    verify_idempotence params[:request_token]
  	if Recipient.exists?(:user_id => params[:id])
  		@response = Recipient.where(user_id: params[:id])
  	else
  		stripe_account = create_stripe_merchant
  		@response = Recipient.create(
  		user_id: params[:id], 
  		gateway_account_id: stripe_account.id, 
  		gateway_type: "stripe")
  	end
  	render "index"
  end

  def create_transaction
    verify_idempotence params[:request_token]
    payer_email = params[:payer_email]
  	stripe_source_token = params[:stripe_source_token]
    amount = params[:amount]
  	payer = Payer.where(user_id: params[:payer_id]).first
  	recipient = Recipient.where(user_id: params[:recipient_id]).first

    if !recipient
       @response = "Recipient doesnt exist"
    else
      if !payer
        payer = Payer.new(
          user_id: params[:payer_id]
        )
        customer = create_stripe_customer(params[:email], stripe_source_token)
        payer.gateway_account_id = customer.id
        payer.gateway_type = "stripe"
        payer.save
      end
    	bill = Bill.create(
    		bill_type: params[:type], 
    		creator_id: params[:creator_id], 
    		payer_id: payer.user_id,
    		recipient_id: recipient.user_id,
    		amount:amount,
    		currency: "USD",
    		status: "complete",
    		notes: params[:notes],
    		completion_deadline: Time.now)

    	payment = create_stripe_payment(
    		amount, 
    		payer.gateway_account_id,
        stripe_source_token,
    		recipient.gateway_account_id)

    	transaction = Transaction.create(
    		payer_id: payer.user_id,
    		recipient_id: recipient.user_id,
    		bill_id: bill.id,
    		gateway_transaction_id: payment.id,
    		gateway_type: "stripe"
    	)
      @response = transaction
    end
  	render "index"
  end

  def verify_idempotence(token)
    raise "Request token missing" if !token
    raise "Detected duplicate request" if $cache.get(token)
    $cache.set(token, 1)
  end
end
