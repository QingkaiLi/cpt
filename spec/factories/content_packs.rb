FactoryGirl.define do
  factory :content_pack do
    sequence(:name) {|n| Faker::Company.name + "#{n}" }
    description {Faker::Lorem.sentence 5 + Random.rand(5)}
    association :user
    association :content_type
    association :status
  end

  factory :invalid_content_pack, parent: :content_pack do
    name nil
  end

  factory :published_content_pack, parent: :content_pack do
    status {Status.find_by_name('Published')}
  end
end
