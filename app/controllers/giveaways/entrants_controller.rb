require_dependency "giveaways/application_controller"

module Giveaways
  class EntrantsController < ApplicationController

  	before_action :ensure_admin, only: [:index, :draw]

  	def index
  		@giveaway = load_giveaway
  		@entrants = @giveaway.entrants.page(params[:page]).per(50)
  	end

    def draw
      @giveaway = load_giveaway
      @winners  = GiveawayDraw.perform(@giveaway)

      redirect_to giveaway_winners_path(@giveaway)
    end

  	protected

  	def load_giveaway
  		Giveaway.find(params[:giveaway_id])
  	end
  end
end
