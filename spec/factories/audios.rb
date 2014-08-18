FactoryGirl.define do
  factory :audio do
    file_name {Faker::Name.name}
    audio ''
    version ''
  end
end
