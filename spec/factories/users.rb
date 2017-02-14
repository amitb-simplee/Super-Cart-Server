FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password "1234"
  end
end
