# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

admin = User.create(email: 'jason@admin.com', password: 'password', admin: true)
admin.transactions.create(action: 'cash in', amount: 1000)
jason =
  User.create(
    email: 'jason.ho@obf.ateneo.edu',
    password: 'password',
    admin: false,
    approved: true,
  )
jason.transactions.create(action: 'cash in', amount: 2000)
jason.transactions.create(
  action: 'purchase',
  amount: -420.69,
  stock: 'TSLA',
  quantity: 2,
)
jason.transactions.create(
  action: 'sale',
  amount: +690,
  stock: 'TSLA',
  quantity: 1,
)
