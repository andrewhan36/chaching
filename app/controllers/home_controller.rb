class HomeController < ApplicationController
  # include MyGate
  def index
  	@mygate = MyGate::Client.instance.test_method
  end
end
