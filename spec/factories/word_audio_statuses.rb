FactoryGirl.define do
  factory :word_audio_status do
    spelling {Faker::Name.name}
    enabled true
    description ''
    
    association :audio_status
    association :audio
    association :user
  end
end
