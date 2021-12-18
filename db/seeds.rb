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

paul =
  User.create(
    email: 'paul@stocks.com',
    password: 'password',
    admin: false,
    approved: false,
    name: 'Paul Graham',
  )

sam =
  User.create(
    email: 'sam@stocks.com',
    password: 'password',
    admin: false,
    approved: false,
    name: 'Sam Altman',
  )

michael =
  User.create(
    email: 'michael@stocks.com',
    password: 'password',
    admin: false,
    approved: false,
    name: 'Michael Seibel',
  )
