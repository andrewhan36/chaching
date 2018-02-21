require "#{Rails.root}/app/helpers/payment_action_helper.rb"

include PaymentActionHelper

desc "This task is called by the Heroku scheduler add-on"

# for all of the recurring bills in the database, create a bill
task :process_recurring_bills => :environment do
	time_now = Time.now
  	triggered_bills = RecurringBill.all.select { |bill| bill.trigger_datetime <= time_now }
  	triggered_bills.each { |bill| process_recurring_bill(bill) }
end