class PendingBillsController < ApplicationController
	def new
	end

	def create
	  @pending_bill = PendingBill.new(params[:pending_bill].permit(:name))
 	  @pending_bill.uuid = SecureRandom.uuid
	  @pending_bill.save
	  redirect_to @pending_bill
	end

	def show
		@pending_bill = PendingBill.find(params[:id])
	end

	def index
		@pending_bill_list = PendingBill.last(20)
	end
end
