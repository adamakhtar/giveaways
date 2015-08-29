require 'rails_helper'

module Giveaways
  RSpec.describe EntriesController, type: :controller do

    before do
      @routes = Giveaways::Engine.routes
    end
    
    describe "GET to new" do
      it "renders new" do
        stub_giveaway

        get :new, giveaway_id: 1

        expect(response).to render_template('new')
      end
    end

    describe "POST to create" do
      context "when a referral" do
        it "is success when valid" do
          stub_giveaway
          entrant = build_stubbed(:entrant)
          allow(EntrantRegistrar).to receive(:register).and_return(entrant)
        
          post :create, giveaway_id: 1, referral: 'abcd', entrant: attributes_for(:entrant)

          expect(response).to be_redirect
        end
      end

      context "when not a referral" do
        it "is success when valid" do
          stub_giveaway
          entrant = build_stubbed(:entrant)
          allow(EntrantRegistrar).to receive(:register).and_return(entrant)
        
          post :create, giveaway_id: 1, entrant: attributes_for(:entrant)

          expect(response).to be_redirect
        end
      end 
      
      
      it "renders new template when not valid" do
        stub_giveaway
        entrant = build_stubbed(:entrant, first_name: nil)
        allow(EntrantRegistrar).to receive(:register).and_return(entrant)
        
        post :create, giveaway_id: 1, entrant: attributes_for(:entrant)

        expect(response).to render_template('new')
      end
    end
  end
end
