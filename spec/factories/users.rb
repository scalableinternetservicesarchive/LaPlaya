FactoryGirl.define do

  factory :user, aliases: [:author] do
    sequence(:username) { |n| Faker::Internet.user_name + "#{n}" }
    sequence(:email) { |n| (Faker::Internet.email).sub('@',"#{n}@") }
    password { Faker::Internet.password }
  end

end