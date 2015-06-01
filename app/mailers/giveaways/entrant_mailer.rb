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
  		mail to: entrant.email, body: body, content_type: "text/plain", subject: giveaway.email_subject
  	end
  end
end
