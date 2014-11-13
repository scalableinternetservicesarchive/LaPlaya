# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :project do
    author
    title { Faker::Lorem.sentence }
    about { Faker::Lorem.paragraph }
    instructions { Faker::Lorem.paragraph }
    thumbnail { "#{Faker::Avatar.image(Faker::Lorem.words.join, "600x450")}&bgset=#{%w(bg1 bg2).sample}" }
  end

end
