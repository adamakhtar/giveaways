FactoryGirl.define do
  factory :giveaway, :class => 'Giveaways::Giveaway' do
    title "Ipad Giveaway"
		description "Win a new ipad."
		thank_you_message "Thank you for entering"
		starts_at 1.day.from_now
		ends_at 1.week.from_now
		number_of_prizes 1
  end
end
