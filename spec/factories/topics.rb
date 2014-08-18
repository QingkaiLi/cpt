FactoryGirl.define do
  factory :topic do
    name {Faker::Company.name}
    grade_level 3
    default false

    association :content_pack
  end

  factory :invalid_topic, parent: :topic do
    name nil
    grade_level 'test'
  end

end
