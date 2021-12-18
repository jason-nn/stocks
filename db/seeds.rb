# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

admin =
  User.create(
    email: 'admin@stocks.com',
    password: 'password',
    admin: true,
    approved: true,
    name: 'Admin',
  )

jason =
  User.create(
    email: 'jason@stocks.com',
    password: 'password',
    admin: false,
    approved: true,
    name: 'Jason Ho',
  )

pg =
  User.create(
    email: 'pg@stocks.com',
    password: 'password',
    admin: false,
    approved: false,
    name: 'Paul Graham',
  )

# pg.transactions.create(action: 'cash in', amount: 1000)

# jason.transactions.create(action: 'cash in', amount: 2000)

# jason.transactions.create(
#   action: 'purchase',
#   amount: -1800,
#   stock: 'TSLA',
#   quantity: 2,
# )

# jason.transactions.create(
#   action: 'sale',
#   amount: 1000,
#   stock: 'TSLA',
#   quantity: 1,
# )
