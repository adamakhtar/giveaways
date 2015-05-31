FactoryGirl.define do
  factory :giveaway, :class => 'Giveaways::Giveaway' do
    title "Ipad Giveaway"
		description "Win a new ipad."
		starts_at 1.day.from_now
		ends_at 1.week.from_now
		number_of_prizes 1
  end
end
