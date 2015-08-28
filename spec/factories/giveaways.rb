FactoryGirl.define do
  factory :giveaway, :class => 'Giveaways::Giveaway' do
    title "Ipad Giveaway"
    name "ipad"
		description "Win a new ipad."
		thank_you_message "Thank you for entering"
		email_from "Adam"
		email_reply_to "adam@example.com"
		email_subject "Confirm your email"
		email_message "Please click this link"
		starts_at 1.day.from_now
		ends_at 1.week.from_now
		number_of_prizes 1
    ballots_per_referral 1

    trait :open do 
      starts_at 1.day.ago
    end
  end
end
