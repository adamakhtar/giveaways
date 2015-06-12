FactoryGirl.define do
	sequence :email do |n|
		"me#{n}@example.com"
	end
	
  factory :entrant, :class => 'Giveaways::Entrant' do
    first_name "Bob"
		email
  end
end
