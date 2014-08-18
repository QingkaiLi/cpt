FactoryGirl.define do
  factory :user do
    provider {Faker::Company.name}
    name {Faker::Name.name}
    uid {"#{Random.rand (Time.zone.now - 1.day).to_i}"}
  end
end
