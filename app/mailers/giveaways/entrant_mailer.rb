require 'liquid'

module Giveaways
  class EntrantMailer < ApplicationMailer
  	def confirm_email(entrant_id)
  		entrant = Entrant.find(entrant_id)
  		giveaway = entrant.giveaway
  	
      body = ConfirmationEmailFormatter.format(
        message: giveaway.email_message,
        first_name: entrant.first_name, 
        confirmation_path: confirmation_url(entrant.confirmation_token),
        referral_path: entry_url(giveaway, referral: entrant.referral_token), 
        chances_per_referral: giveaway.ballots_per_referral
      )

  		mail(
        content_type: "text/html", 
        to: entrant.email, 
        from: giveaway.email_from,
        reply_to: giveaway.email_reply_to,
        subject: giveaway.email_subject,
        body: body
      )
  	end
  end
end
