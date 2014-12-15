# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :gallery do
    title { Faker::Lorem.sentence(2, false, 4) }
    author
    thumbnail { "http://cs290.s3.amazonaws.com/LaPlaya/pics/#{rand(1..25)}.png" }


    transient do
      projects_count 0
    end

    after(:build) do |gallery, evaluator|
      if evaluator.projects_count > 0 && gallery.projects.empty?
        gallery.projects = FactoryGirl.create_list(:project, evaluator.projects_count)
      end
    end
  end
end
