# Set your secret key: remember to change this to your live secret key in production
# See your keys here: https://dashboard.stripe.com/account/apikeys
module StripeHelper
  def create_stripe_customer(email, source_token)
    customer = Stripe::Customer.create({
      email: email,
      source: source_token,
    })
  end

  def create_stripe_merchant
  	acct = Stripe::Account.create({
  	    :country => "US",
  	    :type => "custom"
  	})
  end

  def create_stripe_payment(amount, customer_id, source_account_id, destination_account_id)
    charge = Stripe::Charge.create({
      :amount => amount,
      :currency => "usd",
      :customer => customer_id,
      :source => source_account_id,
      :destination => {:account => destination_account_id}})
  end
end