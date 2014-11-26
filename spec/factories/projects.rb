# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :project do
    author
    title { Faker::Lorem.sentence }
    about { Faker::Lorem.paragraph }
    instructions { Faker::Lorem.paragraph }
    thumbnail { "#{Faker::Avatar.image(Faker::Lorem.words.join, "600x450")}&bgset=#{%w(bg1 bg2).sample}" }

    transient do
      tags_count 0
    end

    trait(:with_tags) do
      transient do
        tags_count 10
      end
    end

    after(:build) do |project, evaluator|
      if evaluator.tags_count > 0 && project.tags.empty?
        project.tags = FactoryGirl.create_list(:tag, evaluator.tags_count)
      end
    end

  end

end
