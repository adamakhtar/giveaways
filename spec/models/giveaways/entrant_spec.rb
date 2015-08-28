require 'rails_helper'

module Giveaways
  RSpec.describe Entrant, type: :model do
    it "validates name and email" do
    	entrant = Entrant.new
 			entrant.valid?
    	expect(entrant.errors).to include :email
      expect(entrant.errors).to include :first_name
    end

    it "validates email address is unique for parent giveaway" do
    	giveaway = create(:giveaway)
    	entrant = create(:entrant, email: 'bob@example.com', giveaway: giveaway)
    	cheater = build(:entrant, email: 'bob@example.com', giveaway: giveaway)

    	expect(cheater).to_not be_valid
    	expect(cheater.errors.full_messages).to include 'Email has already been registered for this giveaway. Check your email for notification.'
    end

    describe "#register" do
      it "saves, creates a ballot and sends a valid entrant confirmation email" do
        mailer = stub_mailer
        entrant = build(:entrant)

        result = entrant.register

        expect(entrant).to be_persisted
        expect(mailer).to have_received(:confirm_email)
        expect(entrant.ballots.count).to eq 1
        expect(result).to be true
      end

      it "doesn't send confirmation email to invalid entry" do
        mailer = stub_mailer
        entrant = build(:entrant, email: "")

        result = entrant.register

        expect(mailer).to_not have_received(:confirm_email)
        expect(result).to be false
      end

      def stub_mailer
        mailer = double("mailer", deliver_later: true)
        allow(EntrantMailer).to receive(:confirm_email).and_return(mailer)
        EntrantMailer
      end
    end

    describe ".confirm_email" do
      it "when give key is valid sets email_confirmed to true" do
        entrant = create(:entrant)

        result = Entrant.confirm_email(entrant.confirmation_token)
        entrant.reload

        expect(result).to be_truthy
        expect(entrant.confirmed_email?).to be_truthy
      end
    end

    describe ".reward_referral" do
      it "increments entrants ballots count by given ammount" do
        entrant = create(:entrant, :registered)
        expect(entrant.ballots.count).to eq 1
        entrant.reward_referral(3)
        expect(entrant.ballots.count).to eq 4
      end
    end
  end
end
