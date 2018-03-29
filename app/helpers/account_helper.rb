module AccountHelper
  include StripeHelper
  def create_merchant(entity_type, business_name, full_name, dob, stripe_call=false)
    merchant = Merchant.new(name: business_name)
   	if stripe_call
      payee = StripeHelper.create_account(merchant.uuid)
      merchant.payee_uuid = payee.uuid
    end
    merchant.save
  end
end