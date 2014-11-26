FactoryGirl.define do
  factory :tag do
    name { Faker::Lorem.word }
    initialize_with { Tag.find_or_create_by(name: name)}
  end
end
