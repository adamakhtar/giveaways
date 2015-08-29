require_dependency "giveaways/application_controller"

module Giveaways
  class EntrantsController < ApplicationController
    
    layout :resolve_layout

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

    def resolve_layout
      case action_name
      when 'new', 'thank_you', 'confirm', 'create'
        Giveaways.public_layout 
      else
        Giveaways.admin_layout
      end
    end
  end
end
