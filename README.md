# README

To get started...

Set your environment STRIPE_API_KEY.

## API Doc

### Bills
Bills keep track of all the information related to a transaction. Every transaction will have a bill id as a reference.
```
Bill
{
	bill_type
	creator_id
	payer_id
	recipient_id
	amount
	currency
	status
	notes
	completion_deadline
	created_at
	updated_at
}
```

To fetch a specific bill with id  
`GET 1.0/bill/:id`

To fetch all bills  
`GET /1.0/bill`

### Payer
Payers hold the user id and maps it to a gateway payer id. This is to process a transaction by just passing your application's user id. No need to remember the gateway information.
```
Payer
{
	user_id
	gateway_account_id
	gateway_type
	created_at
	updated_at
}
```
To fetch a specific payer with id  
`GET /1.0/payer/:user_id`

To fetch all payers  
`GET /1.0/payer`

To create a payer  
```
POST /1.0/payer

--data
{
	request_token: (idempotent token for every request)
	user_id:
	email:
	stripe_source_token: (stripe payment token)
}
```

### Recipient
Recipients hold the user id and maps it to a gateway recipient id. This is to process a transaction by just passing your recipient's user id. No need to remember the gateway information.
```
Recipient
{
	user_id
	gateway_account_id
	gateway_type
	created_at
	updated_at
}
```
To fetch a specific recipient with id  
`GET /1.0/recipient/:user_id`

To fetch all recipients  
`GET /1.0/recipient`

To create a recipient 
```
POST /1.0/recipient

--data
{
	request_token: (idempotent token for every request)
	user_id:
	country:
	dob_day: (1-31)
	dob_month: (1-12)
	dob_yeaar: (4 digits)
	business_name:
	first_name:
	last_name:
}
```

### Transaction
Transactions demonstrate a movement of funds. It mainly tells you how much money was involved and which users were involved. Every transactin will have a bill associated to it for more business logic details about it.
```
Transaction
{
	payer_id
	recipient_id
	bill_id
	gateway_transaction_id
	gateway_type
	created_at
	updated_at
}
```
To fetch a specific transaction with id  
`GET /1.0/transaction/:id`

To fetch all transactions  
`GET /1.0/transaction`

To create a transaction  
```
POST /1.0/transaction`

--data
{
	request_token: (idempotent token for every request)
	payer_id: (if payer exists)
	payer_email: (if new payer)
	stripe_source_token: (stripe payment token)
	amount:
	recipient_id:
	creator_id:
	bill_type:
	notes:
}
```

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
