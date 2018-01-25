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
  price: 5.0,
  vendor_price: 4.0,
  active: true
)
Item.create!(
  name: "Small Lemonade",
  drink_type: "lemonade",
  cup_type: 'small',
  price: 3.0,
  vendor_price: 2.5,
  active: true
)
Item.create!(
  name: "Medium Coffee",
  drink_type: "hot",
  cup_type: 'hot_medium',
  price: 2.5,
  vendor_price: 2.0,
  active: true
)
Item.create!(
  name: "Small Coffee",
  drink_type: "hot",
  cup_type: 'hot_small',
  price: 2.0,
  vendor_price: 1.5,
  active: true
)
Item.create!(
  name: "Water Bottle",
  drink_type: "water",
  cup_type: 'bottle',
  price: 1.0,
  vendor_price: 1.0,
  active: true
)
Item.create!(
  name: "Large Arnold Palmer",
  drink_type: "lemonade",
  cup_type: 'large',
  price: 5.0,
  vendor_price: 4.0,
  active: true
)
Item.create!(
  name: "Large Tea",
  drink_type: "tea",
  cup_type: 'large',
  price: 4.0,
  vendor_price: 3.0,
  active: true
)
Item.create!(
  name: "Lg Special Lemonade",
  drink_type: "water",
  cup_type: 'large',
  price: 6.5,
  vendor_price: 5.0,
  active: true
)
Item.create!(
  name: "Lg Special Tea",
  drink_type: "tea",
  cup_type: 'large',
  price: 5.0,
  vendor_price: 4.0,
  active: true
)
Item.create!(
  name: "Med Hot Tea",
  drink_type: "hot",
  cup_type: 'hot_medium',
  price: 2.0,
  vendor_price: 1.5,
  active: true
)
Item.create!(
  name: "Medium Chai",
  drink_type: "hot",
  cup_type: 'hot_medium',
  price: 3.5,
  vendor_price: 3.0,
  active: true
)
Item.create!(
  name: "Medium Cider",
  drink_type: "hot",
  cup_type: 'hot_medium',
  price: 3.5,
  vendor_price: 3.0,
  active: true
)
Item.create!(
  name: "Medium Cocoa",
  drink_type: "hot",
  cup_type: 'hot_medium',
  price: 3.5,
  vendor_price: 3.0,
  active: true
)
Item.create!(
  name: "Small Arnold Palmer",
  drink_type: "lemonade",
  cup_type: 'small',
  price: 3.0,
  vendor_price: 2.5,
  active: true
)
Item.create!(
  name: "Small chai",
  drink_type: "hot",
  cup_type: 'hot_small',
  price: 3.0,
  vendor_price: 2.5,
  active: true
)
Item.create!(
  name: "Small Cider",
  drink_type: "hot",
  cup_type: 'hot_small',
  price: 3.0,
  vendor_price: 2.5,
  active: true
)
Item.create!(
  name: "Small Cocoa",
  drink_type: "hot",
  cup_type: 'hot_small',
  price: 3.0,
  vendor_price: 2.5,
  active: true
)
Item.create!(
  name: "Small Tea",
  drink_type: "tea",
  cup_type: 'small',
  price: 2.5,
  vendor_price: 2.0,
  active: true
)
Item.create!(
  name: "Sm Hot Tea",
  drink_type: "hot",
  cup_type: 'hot_small',
  price: 2.0,
  vendor_price: 1.5,
  active: true
)
Item.create!(
  name: "Sm Special Lemonade",
  drink_type: "lemonade",
  cup_type: 'small',
  price: 4.0,
  vendor_price: 3.5,
  active: true
)
Item.create!(
  name: "Sm Special Tea",
  drink_type: "tea",
  cup_type: 'small',
  price: 3.5,
  vendor_price: 3.0,
  active: true
)


Admin.create!(
  password: 'WillsButt',
  password_confirmation: 'WillsButt',
  employees: ['Alan','Desiree','Matt'],
  locations: ['Marion Square', 'James Island', 'Market Street']
)
