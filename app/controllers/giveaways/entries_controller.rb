require_dependency "giveaways/application_controller"

module Giveaways
  class EntriesController < ApplicationController

    layout Giveaways.public_layout 

    def new
      @giveaway = load_giveaway
      @entrant = Entrant.new
    end

    def create
      @giveaway = load_giveaway
      @entrant = EntrantRegistrar.register(@giveaway, entrant: entrant_params, referrel_token: params[:referral]) 
      
      if @entrant.valid?
        redirect_to giveaway_entries_path(@giveaway)
      else
        render :new
      end
    end

    def show
      @giveaway = load_giveaway
      render :thank_you
    end

    def thank_you
      @giveaway = load_giveaway
    end

    protected

    def entrant_params
      params.require(:entrant).permit(:email, :first_name, :agree_to_rules)
    end

    def load_giveaway
      Giveaway.find(params[:giveaway_id])
    end
  end
end
