FactoryGirl.define do
  factory :selection do
    title {Faker::Company.name}
    description 'test'
    illustrator 'test_author'
    grade_equivalent_level 1.3
    internationally true
    
 
    association :updater, factory: :user
    association :status
    association :topic
  end
end
