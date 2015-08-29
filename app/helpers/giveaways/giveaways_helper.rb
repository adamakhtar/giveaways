module Giveaways
  module GiveawaysHelper
    def rendered_thank_you_message(giveaway)
      Giveaways::ConfirmationEmailFormatter.format(
        message: giveaway.email_message,
        first_name: 'Adam', 
        confirmation_path: confirmation_url('1x2y3z'),
        referral_path: entry_url(giveaway, referral: '1x2y3z'), 
        chances_per_referral: giveaway.ballots_per_referral
      )
    end
  end
end
