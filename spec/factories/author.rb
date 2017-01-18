FactoryGirl.define do
  factory :author do
    name {Faker::Book.unique.author}
    bio {Faker::Lorem.paragraph(3)}
  end
end
