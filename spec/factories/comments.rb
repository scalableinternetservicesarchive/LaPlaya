# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :comment do
    text { Faker::Lorem.paragraph }
    author
    project
  end

end
