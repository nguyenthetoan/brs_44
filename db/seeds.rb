# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
#User.create!(name: "Invoker", email: "thetoan95@gmail.com", password: "123456",
#  password_confirmation: "123456", role: :admin)

24.times do |n|
  name = Faker::Book.unique.author
  bio = Faker::Lorem.paragraph(3)
  Author.create!(name: name, bio: bio)
end

15.times do |n|
  name = Faker::Book.publisher
  desc = Faker::Lorem.paragraph(2)
  Publisher.create!(name: name, description: desc)
end

10.times do |n|
  name = Faker::Book.unique.genre
  Category.create!(name: name, lft: 0, rgt: 0)
end

30.times do |n|
  title = Faker::Book.title
  publish_date = Faker::Date.backward(365)
  pages = Faker::Number.between(10, 3000)
  cate = Faker::Number.between(1, 10)
  desc = Faker::Lorem.paragraph(7)
  auth_id = Faker::Number.between(1, 24)
  pub_id = Faker::Number.between(1, 15)
  Book.create!(title: title, publish_date: publish_date, pages: pages,
    category_id: cate, description: desc, author_id: auth_id, publisher_id: pub_id)
end
