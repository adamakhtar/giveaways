require 'rails_helper'

module Giveaways
  RSpec.describe GiveawaysController, type: :controller do 

  	before do
  		@routes = Giveaways::Engine.routes
  	end

  	describe "GET to index" do
  		it "responds with success" do
 				get :index
 				expect(response).to be_success
 			end
  	end
  end
end
