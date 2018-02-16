require 'singleton'
module MyGate
	class Client
		include Singleton
		def test_method
			Time.now
		end	
	end
end