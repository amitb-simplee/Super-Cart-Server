FactoryGirl.define do
  factory :cart do |f|
    f.date Time.zone.now
    f.name "factory girl cart"
  end
end
