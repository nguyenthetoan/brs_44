FactoryGirl.define do
  factory :category do
    name {Faker::Book.unique.genre}
    lft {Faker::Number.number(1)}
    rgt {Faker::Number.number(1)}
  end
end
