require_dependency "giveaways/application_controller"

module Giveaways
  class GiveawaysController < ApplicationController
  	def index
  		@giveaways = Giveaway.all
  	end
  end
end
