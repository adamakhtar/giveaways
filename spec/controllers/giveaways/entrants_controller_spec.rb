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
      it "is success when valid" do
        stub_giveaway
        allow_any_instance_of(Entrant).to receive(:register).and_return(true)
      
        post :create, giveaway_id: 1, entrant: attributes_for(:entrant)

        expect(response).to render_template('thank_you')
      end
      
      
      it "renders new template when not valid" do
        stub_giveaway
        allow_any_instance_of(Entrant).to receive(:register).and_return(false)  

        post :create, giveaway_id: 1, entrant: attributes_for(:entrant)

        expect(response).to render_template('new')
      end
    end
  end
end
