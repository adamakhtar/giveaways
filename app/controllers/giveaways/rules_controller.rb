require_dependency "giveaways/application_controller"

module Giveaways
  class RulesController < ApplicationController
    
    layout Giveaways.public_layout

    def show
      @giveaway = Giveaway.find(params[:giveaway_id])
    end
  end
end
