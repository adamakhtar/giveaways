FactoryGirl.define do
  factory :entrant, :class => 'Giveaways::Entrant' do
    first_name "Bob"
		email "bob@example.com"
		confirmation_token SecureRandom.urlsafe_base64
  end
end
