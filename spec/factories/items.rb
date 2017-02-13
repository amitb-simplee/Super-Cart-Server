FactoryGirl.define do
  factory :item do |f|
    f.name { Faker::Food.ingredient }
    f.quantity { Faker::Food.measurement }
    f.note "note test"
    f.checked false
  end
end
