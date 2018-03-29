module PaymentActionHelper

  def one_time_payment_action(payment_type, creator_uuid, user_uuid, merchant_uuid, amount)
    new_bill = Bill.new(
      bill_type: "one time payment", 
      creator_uuid: user_uuid, 
      payer_uuid: user_uuid,
      payee_uuid:merchant_uuid,
      amount:amount,
      currency: "USD",
      status: "approved",
      recurring: false)
    new_bill.save
  end

	def create_payment(bill_uuid)
    new_payment = Payment.new(
  		bill_uuid: bill_uuid,
  		gateway_payment_id: SecureRandom.uuid,
  		gateway: "braintree"
  	)
  	new_payment.save
  	puts new_payment.to_json
  	return new_payment.uuid
  end


  def create_recurring_bill(bill_uuid)
  	seconds_in_a_day = 86400
  	RecurringBill.new(
  		bill_uuid: bill_uuid, 
  		trigger_datetime:Time.now + seconds_in_a_day.seconds,
  		creation_interval_seconds: seconds_in_a_day).save
  end

  def process_recurring_bill(recurring_bill)
  	original_bill = Bill.where(uuid:recurring_bill.bill_uuid).first

  	create_payment(original_bill.uuid) if original_bill.status== "approved"

  	recurring_bill.trigger_datetime += recurring_bill.creation_interval_seconds.seconds
  	recurring_bill.save
  end

  def process_payouts(payee_uuid)
    pending_payouts = PendingPayout.where("payee_uuid = (?) AND created_at <= (?)", payee_uuid, 1.days.ago)
    puts pending_payouts.to_json
    return if pending_payouts.empty?
    
    Payout.new(
      payee_uuid: payee_uuid,
      amount: pending_payouts.sum(:amount),
      currency: pending_payouts.first.currency).save

    pending_payouts.delete_all

    payee = Payee.find_by(uuid: payee_uuid)
    payee.update(next_payout: payee.next_payout + 2.days)
  end

end
