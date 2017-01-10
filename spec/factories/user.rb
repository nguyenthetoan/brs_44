FactoryGirl.define do
  factory :user do
    name {Faker::Name.unique.name}
    email {Faker::Internet.email}
    password 123456
    confirmed_at {Time.zone.now}
  end
end
