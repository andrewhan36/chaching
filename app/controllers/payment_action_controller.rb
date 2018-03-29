class PaymentActionController < ApplicationController
	include PaymentActionHelper
  def index
  	@payment_types = ["rent", "maintenance", "cleaning", "association fee", "parking fee"]
  	@status_types = ["approved", "pending"]
  	@payments = Payment.all.reverse_order
  	@pending_bills = pending_bills.reverse_order
  	@approved_bills = approved_bills.reverse_order
  	@recurring_bills = RecurringBill.all
  	@payers = Payer.all
  	@payees = Payee.all
	  @users = User.all
  	@merchants = Merchant.all
  	@payouts = Payout.all
  	@pending_payouts = PendingPayout.all

  	@models = {
  		"Payments" => @payments,
  		"Pending Bills" => @pending_bills,
  		"Approved Bills" => @approved_bills,
  		"Recurring Bills" => @recurring_bills,
  		"Users" => @users,
  		"Merchants" => @merchants,
		  "Payers" => @payers,
  		"Payees" => @payees,
  		"Payouts" => @payouts,
  		"Pending Payouts" => @pending_payouts,
  	 }
  end

  def create
  	process_request(params)
  	redirect_back fallback_location: @get
  end

  def approve
  	bill_uuid = params[:process_pending_request][:bill_uuid]
  	bill = Bill.where(uuid:bill_uuid).first
  	if bill
  		bill.update(status: "approved")
  		new_payment = Payment.new(
			bill_uuid: bill.uuid,
			gateway_payment_id: SecureRandom.uuid,
			gateway: "braintree"
		)

		bill.update(payment_uuid:new_payment.uuid)

		logger.info new_payment.to_json
		new_payment.save
  	end
  	redirect_back fallback_location: @get
  end

  def process_request(params)
  	user_uuid = params[:payment_request][:user_uuid]
  	merchant_uuid = params[:payment_request][:merchant_uuid]
  	payment_type = params[:payment_request][:payment_type]
  	amount = params[:payment_request][:amount]
  	request_status = params[:payment_request][:status_type]
  	recurring = params[:payment_request][:recurring]

  	new_bill = Bill.new(
  		bill_type: payment_type, 
  		creator_uuid: user_uuid, 
  		payer_uuid: user_uuid,
  		payee_uuid:merchant_uuid,
  		payment_due: 1.day.from_now,
  		amount:amount,
  		currency: "USD",
  		status: request_status,
  		recurring: recurring)
  	
  	logger.info new_bill.to_json

  	create_recurring_bill(new_bill.uuid) unless recurring == "0"
  	new_bill.payment_uuid = create_payment(new_bill.uuid) unless request_status == "pending"
  	
  	new_bill.save
  end

  def pending_bills
	 Bill.where(status: "pending")
  end

  def approved_bills
	 Bill.where(status: "approved")
  end
end
