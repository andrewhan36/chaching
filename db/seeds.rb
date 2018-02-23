# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(name:"Jeff")
User.create(name:"Snookie")
User.create(name:"Joe")
User.create(name:"Ned")

Merchant.create(uuid: "bf83ab3e-8198-492e-bce8-d0597f477b29", name:"Chick Fil a")
Merchant.create(name:"House Stark")
Merchant.create(name:"SpaceX")

PendingPayout.create(payee_uuid:"3c56ed0e-f4a2-4fa3-850e-c239c0466297", amount: 12.30, currency:"USD")
PendingPayout.create(payee_uuid:"3c56ed0e-f4a2-4fa3-850e-c239c0466297", amount: 2.75, currency:"USD")

Payee.create(uuid: "3c56ed0e-f4a2-4fa3-850e-c239c0466297", merchant_uuid:"bf83ab3e-8198-492e-bce8-d0597f477b29", next_payout: Time.now);