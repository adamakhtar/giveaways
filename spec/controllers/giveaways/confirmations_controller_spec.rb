require 'rails_helper'

include StubGiveawayHelper

module Giveaways
  RSpec.describe ConfirmationsController, type: :controller do

    before do
      @routes = Giveaways::Engine.routes
    end

    describe "GET to confirm" do
      it "is success when valid" do
        entrant = stub_entrant_with_key
        expect(entrant).to receive(:confirm_email!)

        get :update, id: entrant.confirmation_token

        expect(response).to redirect_to completed_confirmation_path
      end
      
      
      it "is invalid with incorrect key" do
        get :update, id: 'junk'
        
        expect(response).to redirect_to invalid_confirmation_path
      end
    end

    def stub_entrant_with_key  
      entrant = build_stubbed(:entrant)
      allow(Entrant).to receive(:find_by).and_return entrant
      entrant
    end
  end
end
