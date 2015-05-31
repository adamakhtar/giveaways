require_dependency "giveaways/application_controller"

module Giveaways
  class EntrantsController < ApplicationController
  	before_action :ensure_admin, only: :index

  	def index
  		@giveaway = load_giveaway
  		@entrants = @giveaway.entrants.page(params[:page]).per(50)
  	end

    def new
      @giveaway = load_giveaway
      @entrant = Entrant.new
    end

    def create
      @giveaway = load_giveaway
      @entrant = Entrant.new(entrant_params)

      if @entrant.save
        render :thank_you
      else
        render :new
      end
    end

  	protected

    def entrant_params
      params.require(:entrant).permit(:first_name, :email)
    end

  	def load_giveaway
  		Giveaway.find(params[:giveaway_id])
  	end
  end
end
