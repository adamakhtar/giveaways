require 'rails_helper'

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
  			giveaway = build_stubbed(:giveaway)
  			stub_giveaway_user_with(Giveaways::FakeAdminUser.new)
  			allow(Giveaway).to receive(:find).and_return(giveaway)

  			get :show, id: 1

 				expect(response).to be_success
  		end

  		it "redirects to configured sign in path when not admin" do
  			giveaway = build_stubbed(:giveaway)
  			stub_giveaway_user_with(Giveaways::FakeUser.new)
  			allow(Giveaway).to receive(:find).and_return(giveaway)
  			
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

        expect(response).to be_success
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
          giveaway = build_stubbed(:giveaway)
          allow(Giveaway).to receive(:find).and_return giveaway
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

  	def stub_giveaway_user_with(user)
  		allow(controller).to receive(:giveaway_user).and_return(user)
  	end
  end
end
