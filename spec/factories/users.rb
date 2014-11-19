FactoryGirl.define do

  factory :user, aliases: [:author] do
    username { Faker::Internet.user_name + rand(100).to_s }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end

end