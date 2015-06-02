require "rails_helper"

module Giveaways
  RSpec.describe EntrantMailer, type: :mailer do
    describe "#confirm_email" do
    	it "delivers an email confirmation email" do
    		giveaway = create(:giveaway, email_subject: 'Hello', email_message: '{{first_name}}')
    		entrant = create(:entrant, giveaway: giveaway)
    		email = EntrantMailer.confirm_email(entrant.id)

    		expect(email).to deliver_to(entrant.email)
    		expect(email).to deliver_from(giveaway.email_from)
        expect(email).to have_subject(giveaway.email_subject)
        expect(email).to have_body_text(entrant.first_name)
        expect(email).to have_reply_to(giveaway.email_reply_to)
    	end
    end
  end
end
