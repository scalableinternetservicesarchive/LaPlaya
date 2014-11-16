# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :gallery do
    title { Faker::Lorem.sentence(2, false, 4) }
    author

    factory :gallery_with_projects do

      # see https://github.com/thoughtbot/factory_girl/blob/v4.4.0/GETTING_STARTED.md#transient-attributes
      # for what this is doing. I want 5 projects to be created with every gallery
      ignore do
        projects_count 5
      end

      after(:create) do |gallery, evaluator|
        gallery.projects = FactoryGirl.create_list(:project, evaluator.projects_count)
      end
    end
  end
end
