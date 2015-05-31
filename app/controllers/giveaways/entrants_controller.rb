require_dependency "giveaways/application_controller"

module Giveaways
  class EntrantsController < ApplicationController
  	before_action :ensure_admin, only: :index

  	def index
  		@giveaway = load_giveaway
  		@entrants = @giveaway.entrants
  	end

  	protected

  	def load_giveaway
  		Giveaway.find(params[:giveaway_id])
  	end
  end
end
