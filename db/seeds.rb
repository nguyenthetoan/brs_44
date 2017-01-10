# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
admin = User.new(name: "Invoker", email: "thetoan95@gmail.com", password: "123456",
  password_confirmation: "123456", role: :admin)
admin.skip_confirmation!
admin.save!

10.times do |n|
  name = Faker::Name.unique.name
  email = "bot#{n+1}@domain.com"
  password = "123456"
  confirmed_at = Time.zone.now
  user = User.new(name: name, email: email, password: password,
    password_confirmation: password, role: :user)
  user.skip_confirmation!
  user.save!
end

24.times do |n|
  name = Faker::Book.author
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
  Category.create!(name: name, lft: n, rgt: n+1)
end

30.times do |n|
  title = Faker::Book.title
  publish_date = Faker::Date.backward(365)
  pages = Faker::Number.between(10, 3000)
  cate = Category.select("id").sample().id
  desc = Faker::Lorem.paragraph(7)
  auth_id = Author.select("id").sample().id
  pub_id = Publisher.select("id").sample().id
  Book.create!(title: title, publish_date: publish_date, pages: pages,
    category_id: cate, description: desc, author_id: auth_id, publisher_id: pub_id)
end
