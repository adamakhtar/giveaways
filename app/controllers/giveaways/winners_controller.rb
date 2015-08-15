require_dependency "giveaways/application_controller"

module Giveaways
  class WinnersController < ApplicationController
    def index
      @giveaway = Giveaway.find(params[:giveaway_id])
      @winners = @giveaway.winners.page(params[:page]).per(10)
    end
  end
end
