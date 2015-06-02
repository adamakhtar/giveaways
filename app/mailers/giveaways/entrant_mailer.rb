require 'liquid'

module Giveaways
  class EntrantMailer < ApplicationMailer
  	def confirm_email(entrant_id)
  		entrant = Entrant.find(entrant_id)
  		giveaway = entrant.giveaway
  		tags = {
  			'first_name' => entrant.first_name
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
