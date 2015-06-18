FactoryGirl.define do
	sequence :email do |n|
		"me#{n}@example.com"
	end
	
  factory :entrant, :class => 'Giveaways::Entrant' do
    first_name "Bob"
		email

    trait :registered do
      after :create do |entrant|
        entrant.ballots << create(:ballot)
      end
    end
  end
end
