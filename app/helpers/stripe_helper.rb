# Set your secret key: remember to change this to your live secret key in production
# See your keys here: https://dashboard.stripe.com/account/apikeys

VALID_COUNTRIES = ["US"].freeze

module StripeHelper
  def create_stripe_customer(email, source_token)
    customer = Stripe::Customer.create({
      email: email,
      source: source_token,
    })
  end

  def create_stripe_merchant(country, dob_day, dob_month, dob_year, business_name, first_name, last_name)
    raise StandardError.new "Country not allowed" if !country.upcase.in?(VALID_COUNTRIES)
  	acct = Stripe::Account.create({
  	    country: country,
  	    type: "custom",
        legal_entity: {
          first_name: first_name,
          last_name: last_name,
          business_name: business_name,
          dob: {
            day: dob_day,
            month: dob_month,
            year: dob_year
          },
          type: "company"
        }
  	})
  end

  def update_stripe_merchant_payout(stripe_token, external_account_token)
    account = Stripe::Account.retrieve(stripe_token)
    account.external_accounts.create(external_account: external_account_token)
  end

  def create_stripe_payment(amount, customer_id, source_account_id, destination_account_id)
    charge = Stripe::Charge.create({
      :amount => amount,
      :currency => "usd",
      :customer => customer_id,
      :source => source_account_id,
      :destination => {:account => destination_account_id}})
  end

  def stripe_merchant_accept_tos(stripe_token, ip)
    acct = Stripe::Account.retrieve(stripe_token)
    acct.tos_acceptance.date = Time.now.to_i
    acct.tos_acceptance.ip = ip
    acct.save
  end
end