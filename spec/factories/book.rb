FactoryGirl.define do
  factory :book do
    category
    initialize_with {new(category: category)}
    author
    initialize_with {new(author: author)}
    publisher
    initialize_with {new(publisher: publisher)}
    title {Faker::Book.title}
    publish_date {Faker::Date.backward(365)}
    pages {Faker::Number.between(10, 3000)}
  end
end
