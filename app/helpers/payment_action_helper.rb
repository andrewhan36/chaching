module PaymentActionHelper
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
  	new_bill = original_bill.dup
  	new_bill.uuid = SecureRandom.uuid
  	new_bill.save

  	create_payment(new_bill.uuid) if new_bill.status== "approved"

  	recurring_bill.trigger_datetime += recurring_bill.creation_interval_seconds.seconds
  	recurring_bill.save
  end

end
