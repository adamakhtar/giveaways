FactoryGirl.define do
  factory :user do
    trait :admin do
        giveaways_admin true
    end
  end
end
