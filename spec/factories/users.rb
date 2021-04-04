FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'password' }

    trait :admin do
      after(:build) do |user|
        user.roles = ['admin']
      end
    end
  end
end
