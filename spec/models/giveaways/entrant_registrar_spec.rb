require 'rails_helper'

module Giveaways
  RSpec.describe EntrantRegistrar, type: :model do
    
    describe "#register" do

      context "when entrant has valid referrer key" do
        it "rewards the referrer" do
          giveaway = create(:giveaway)
          valid_params = { entrant: attributes_for(:entrant), referral_token: 'sometoken' }
          registrar = EntrantRegistrar.new(giveaway, valid_params)
          allow(registrar).to receive(:reward_referrer).and_return true

          entrant = registrar.register

          expect(registrar).to have_received(:reward_referrer)
        end
      end

      it "registers a valid entrant" do
        giveaway = create(:giveaway)
        valid_params = { entrant: attributes_for(:entrant) }
        registrar = EntrantRegistrar.new(giveaway, valid_params)

        entrant = registrar.register

        expect(entrant).to be_valid
      end

      it "does not register an invalid entrant" do
        giveaway = create(:giveaway)
        invalid_params = { entrant: { email: 'junk'} }
        registrar = EntrantRegistrar.new(giveaway, invalid_params)

        entrant = registrar.register
        
        expect(entrant).to_not be_valid
      end
    end
  end
end
