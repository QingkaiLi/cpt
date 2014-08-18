FactoryGirl.define do
  factory :topic_selection_relation do
    association :topic
    association :selection
    priority 1
  end

end
