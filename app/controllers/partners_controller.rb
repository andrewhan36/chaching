class PartnersController < ApplicationController
	def new
	end

	def create
	  @partner = Partner.new(params[:partner].permit(:name, :country))
 
	  @partner.save
	  redirect_to @partner
	end

	def show
		@partner = Partner.find(params[:id])
	end

	def index
		@partner_list = Partner.last(20)
	end
end
