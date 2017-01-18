FactoryGirl.define do
  factory :publisher do
    name {Faker::Book.publisher}
    description {Faker::Lorem.paragraph(2)}
  end
end
