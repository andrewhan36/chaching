class ApplicationController < ActionController::API
	rescue_from StandardError, :with => :handle_standarderror
	
	def handle_standarderror(error)
		render json: { error: error.message }, status: :internal_server_error
	end 
end
