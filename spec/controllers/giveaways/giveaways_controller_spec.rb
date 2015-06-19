require 'rails_helper'

include StubGiveawayHelper
include StubGiveawayUserHelper

module Giveaways
  RSpec.describe GiveawaysController, type: :controller do 
    
  	before do
  		@routes = Giveaways::Engine.routes
  	end

  	describe "GET to index" do
  		it "responds with success when admin" do
  			stub_giveaway_user_with(Giveaways::FakeAdminUser.new)

 				get :index

 				expect(response).to be_success
 			end

 			it "redirects to configured sign in path when not admin" do
 				stub_giveaway_user_with(Giveaways::FakeUser.new)

 				get :index

 				expect(response).to redirect_to '/'
 			end
  	end

  	describe "GET to show" do
  		it "responds with success when admin" do
  			giveaway = stub_giveaway
  			stub_giveaway_user_with(Giveaways::FakeAdminUser.new)
  			
  			get :show, id: 1

 				expect(response).to be_success
  		end

  		it "redirects to configured sign in path when not admin" do
  			giveaway = stub_giveaway
  			stub_giveaway_user_with(Giveaways::FakeUser.new)
  			
  			get :show, id: 1

 				expect(response).to redirect_to '/'
  		end
  	end

	 	describe "GET to new" do
	 		it "responds with success when admin" do
	 			stub_giveaway_user_with(Giveaways::FakeAdminUser.new)

	 			get :new

				expect(response).to be_success
	 		end

	 		it "redirects to configured sign in path when not admin" do
	 			stub_giveaway_user_with(Giveaways::FakeUser.new)
	 			
	 			get :new

				expect(response).to redirect_to '/'
	 		end
	 	end

    describe "POST to create" do
      it "redirects to show when valid" do
        stub_giveaway_user_with(Giveaways::FakeAdminUser.new)
      
        post :create, giveaway: attributes_for(:giveaway)

        expect(response).to be_redirect
      end

      it "renders new when not valid" do          
        stub_giveaway_user_with(Giveaways::FakeAdminUser.new)
      
        post :create, giveaway: attributes_for(:giveaway).merge(title: '')

        expect(response).to be_success
      end

      it "redirects to configured sign in path when not admin" do
        stub_giveaway_user_with(Giveaways::FakeUser.new)
        
        post :create

        expect(response).to redirect_to '/'
      end
    end

    describe "GET to edit" do
      it "is success when admin" do
        giveaway = stub_giveaway
        stub_giveaway_user_with(Giveaways::FakeAdminUser.new)

        get :edit, id: 1

        expect(response).to be_success
      end

      it "redirects to configured sign in path when not admin" do
        stub_giveaway_user_with(Giveaways::FakeUser.new)
        
        get :edit, id: 1

        expect(response).to redirect_to '/'
      end
    end

    describe "PUT to update" do
      it "redirects to show when valid" do
        giveaway = stub_giveaway
        allow(giveaway).to receive(:update_attributes).and_return true
        stub_giveaway_user_with(Giveaways::FakeAdminUser.new)
      
        put :update, id: 1, giveaway: attributes_for(:giveaway)

        expect(response).to redirect_to giveaway_path(giveaway)
      end

      it "renders edit when not valid" do          
        giveaway = stub_giveaway
        allow(giveaway).to receive(:update_attributes).and_return false
        stub_giveaway_user_with(Giveaways::FakeAdminUser.new)
      
        put :update, id: 1, giveaway: attributes_for(:giveaway)

        expect(response).to render_template('edit')
      end

      it "redirects to configured sign in path when not admin" do
        stub_giveaway_user_with(Giveaways::FakeUser.new)
        
        put :update, id: 1

        expect(response).to redirect_to '/'
      end
    end

    describe "DELETE to destroy" do
      it "redirects to index when successful" do
        giveaway = stub_giveaway
        allow(giveaway).to receive(:destroy).and_return true
        stub_giveaway_user_with(Giveaways::FakeAdminUser.new)
      
        delete :destroy, id: 1

        expect(response).to redirect_to giveaways_path
      end


      it "redirects to configured sign in path when not admin" do
        stub_giveaway_user_with(Giveaways::FakeUser.new)
        
        delete :destroy, id: 1

        expect(response).to redirect_to '/'
      end
    end
  end
end
