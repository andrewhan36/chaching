class MainController < ApplicationController
  before_action :authenticate
  include StripeHelper
  include ActionController::HttpAuthentication::Token::ControllerMethods

  def payer
  	render json: Payer.where(user_id: params[:id]).first
  end

  def recipient
    render json: Recipient.where(user_id: params[:id]).first
  end

  def transaction
    render json: Transaction.where(id: params[:id]).first
  end

  def bill
    render json: Bill.where(id: params[:id]).first
  end

  def recurring_bill
    render json: RecurringBill.where(id: params[:id]).first
  end

  def payer_list
    render json: Payer.all
  end

  def recipient_list
    render json: Recipient.all
  end

  def transaction_list
    render json: Transaction.all
  end

  def bill_list
    render json: Bill.all
  end

  def recurring_bill_list
    render json: RecurringBill.all
  end

  def create_payer
  	raise StandardError.new "Payer already exists!" if Payer.exists?(:user_id => params[:user_id])

		stripe_account = create_stripe_customer(params[:email], params[:stripe_source_token])

		payer = Payer.create(
  		user_id: params[:user_id], 
  		gateway_account_id: stripe_account.id, 
  		gateway_type: "stripe")
	
  	render json: payer
  end

  def create_recipient
  	raise StandardError.new "Recipient already exists!" if Recipient.exists?(:user_id => params[:user_id])
  		
		stripe_account = create_stripe_merchant(
      params[:country],
      params[:dob_day],
      params[:dob_month],
      params[:dob_year],
      params[:business_name],
      params[:first_name],
      params[:last_name])

		recipient = Recipient.create(
  		user_id: params[:user_id], 
  		gateway_account_id: stripe_account.id, 
  		gateway_type: "stripe")
  	
  	render json: recipient
  end

  def add_recipient_payout
    recipient = Recipient.where(user_id: params[:user_id]).first
    raise StandardError.new "Recipient doesnt exist!" if !recipient
    update_stripe_merchant_payout(recipient.gateway_account_id, params[:external_account_token])
    render json: recipient
  end

  def create_transaction
  	stripe_source_token = params[:stripe_source_token]
    amount = params[:amount]
  	payer = Payer.where(user_id: params[:payer_id]).first
  	recipient = Recipient.where(user_id: params[:recipient_id]).first

    raise StandardError.new "Recipient doesn't exist!" if !recipient
    
    if !payer
      email = params[:payer_email]
      raise StandardError.new "Email missing!" if !email
      payer = Payer.new(
        user_id: params[:payer_id]
      )
      customer = create_stripe_customer(email, stripe_source_token)
      payer.gateway_account_id = customer.id
      payer.gateway_type = "stripe"
      payer.save
    end
    
  	bill = Bill.create(
  		bill_type: params[:bill_type], 
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
    
  	render json: transaction
  end

  protected
  def authenticate
    authenticate_or_request_with_http_token do |token, options|
      begin
        raise if !token
        raise if $cache.get(token)
        $cache.set(token, 1)
        parts = token.split("::")
        raise if parts.count != 2
        raise if parts[0] != $shared_secret
        raise if !DateTime.parse(parts[1]).between?( 5.minutes.ago, Time.now )
        puts "end"
      rescue
          raise StandardError.new "Invalid Request!"
      end
      true
    end
  end
end
