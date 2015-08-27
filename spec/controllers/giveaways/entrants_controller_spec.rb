require 'rails_helper'

include StubGiveawayHelper
include StubGiveawayUserHelper

module Giveaways
  RSpec.describe EntrantsController, type: :controller do

  	before do
  		@routes = Giveaways::Engine.routes
  	end

  	describe "GET to index" do
  		context "when admin" do
  			it "renders index template" do
  				stub_giveaway
	  			stub_giveaway_user_with(Giveaways::FakeAdminUser.new)

	 				get :index, giveaway_id: 1

	 				expect(response).to be_success
	 				expect(response).to render_template('index')
	 			end
  		end
  		
 			it "redirects to configured sign in path when not admin" do
 				stub_giveaway_user_with(Giveaways::FakeUser.new)

 				get :index, giveaway_id: 1

 				expect(response).to redirect_to '/'
 			end
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

    describe "GET to confirm" do
      it "is success when valid" do
        stub_giveaway
        entrant = stub_entrant_with_key
        expect(entrant).to receive(:confirm_email!)

        get :confirm, giveaway_id: 1, key: entrant.confirmation_token

        expect(response.body).to render_template('confirm')
      end
      
      
      it "renders invalid_token template when not valid" do
        stub_giveaway

        get :confirm, giveaway_id: 1, key: 'junk'
        
        expect(response).to render_template('invalid_token')
      end
    end

    def stub_entrant_with_key  
      entrant = build_stubbed(:entrant)
      allow(Entrant).to receive(:find_by).and_return entrant
      entrant
    end
  end
end
