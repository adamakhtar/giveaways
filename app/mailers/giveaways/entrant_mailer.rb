require 'liquid'

module Giveaways
  class EntrantMailer < ApplicationMailer
  	def confirm_email(entrant_id)
  		entrant = Entrant.find(entrant_id)
  		giveaway = entrant.giveaway
  		tags = {
  			'first_name' => entrant.first_name,
        'confirm_email_link' => confirmation_url(entrant.confirmation_token),
        'chances_per_share' => 3,
        'referral_link' => entry_url(giveaway, referral: entrant.referral_token)
  		}
  		body = ::Liquid::Template.parse(giveaway.email_message).render(tags)

  		mail(
        content_type: "text/plain", 
        to: entrant.email, 
        from: giveaway.email_from,
        reply_to: giveaway.email_reply_to,
        subject: giveaway.email_subject,
        body: body
      )
  	end
  end
end
