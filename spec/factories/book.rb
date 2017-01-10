FactoryGirl.define do
  factory :book do
    title {Faker::Book.title}
    publish_date {Faker::Date.backward(365)}
    pages {Faker::Number.between(10, 3000)}
    category_id {Category.select("id").sample().id}
    author_id {Author.select("id").sample().id}
    publisher_id {Publisher.select("id").sample().id}
  end
end
