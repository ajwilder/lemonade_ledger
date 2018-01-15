# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Item.create!(
  name: "Large Lemonade",
  drink_type: "lemonade",
  cup_type: 'large',
  price: 4.0,
  vendor_price: 2.0,
  active: true
)
Item.create!(
  name: "Small Lemonade",
  drink_type: "lemonade",
  cup_type: 'small',
  price: 2.0,
  vendor_price: 1.0,
  active: true
)
Item.create!(
  name: "Medium Coffee",
  drink_type: "coffee",
  cup_type: 'hot_medium',
  price: 2.5,
  vendor_price: 1.0,
  active: true
)
Item.create!(
  name: "Small Coffee",
  drink_type: "coffee",
  cup_type: 'hot_small',
  price: 1.5,
  vendor_price: 0.75,
  active: true
)
Item.create!(
  name: "Water Bottle",
  drink_type: "water",
  cup_type: 'bottle',
  price: 1.5,
  vendor_price: 0.75,
  active: true
)

Admin.create!(
  password: 'WillsButt',
  password_confirmation: 'WillsButt',
  employees: ['Alan','Desiree','Matt'],
  locations: ['Marion Square', 'James Island', 'Market Street']
)
