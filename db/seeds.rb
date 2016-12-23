# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
User.create!(name: "Invoker", email: "invoker@domain.com", password: "123456",
  password_confirmation: "123456", admin: true)
99.times do |n|
  name = Faker::Name.name
  email = "hero-#{n+1}@domain.com"
  password = "123456"
  User.create!(name: name, email: email, password: password,
    password_confirmation: password, admin: false)
end

Category.create!(name: "Anime")
Category.create!(name: "Comic")
Category.create!(name: "Kiddy")
Category.create!(name: "18+")
Category.create!(name: "21+")
Category.create!(name: "IT")
Category.create!(name: "Drama")
Category.create!(name: "Novel")
Category.create!(name: "Mystery")
Category.create!(name: "Adventure")
Category.create!(name: "Gaming")
Category.create!(name: "Computer Programing")
Category.create!(name: "Science")
Category.create!(name: "Documentation")
Category.create!(name: "Romance")

50.times do |n|
  title = Faker::Book.title
  author = Faker::Book.author
  description = Faker::Lorem.paragraph(5)
  publish_date = Faker::Date.backward(30)
  pages = Faker::Number.between(200, 1000)
  category_id = Faker::Number.between(1, 15)
  Book.create!(title: title, author: author, pages: pages, publish_date:
  publish_date, category_id: category_id, description: description)
end
