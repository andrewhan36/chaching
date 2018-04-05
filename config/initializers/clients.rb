$cache = Dalli::Client.new(ENV['MEMCACHE_SERVERS'], { 
    :username => ENV['MEMCACHE_USERNAME'], 
    :password => ENV['MEMCACHE_PASSWORD'], 
    :namespace => "app_v1", 
    :expires_in => 1.day, 
    :compress => true })

$shared_secret = ENV['SHARED_SECRET']

Stripe.api_key = ENV['STRIPE_API_KEY']