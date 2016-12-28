# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
User.create!(name: "Invoker", email: "invoker@domain.com", password: "123456",
  password_confirmation: "123456", role: :admin)
User.create!(name: "Mirana", email: "mirana@domain.com", password: "123456",
  password_confirmation: "123456")
User.create!(name: "Rubitch", email: "rubitch@domain.com", password: "123456",
  password_confirmation: "123456")
User.create!(name: "Crystal Maiden", email: "cm@domain.com", password: "123456",
  password_confirmation: "123456")
User.create!(name: "Timberthaw", email: "timber@domain.com", password: "123456",
  password_confirmation: "123456")

Category.create!(name: "IT")
Category.create!(name: "Comic")
Category.create!(name: "Novel")

Book.create!(title: "Life of Sing", author: "SingSing", pages: 367, publish_date:
  "2005-12-24", category_id: 3)
Book.create!(title: "How to Rails", author: "Railist", pages: 391, publish_date:
  "2015-10-12", category_id: 1)
Book.create!(title: "Davanka", author: "S PLUS", pages: 976, publish_date:
  "1954-08-01", category_id: 2)
