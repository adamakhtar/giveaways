require_dependency "giveaways/application_controller"

module Giveaways
  class GiveawaysController < ApplicationController

  	before_action :ensure_authorized

  	def index
  		@giveaways = Giveaway.all
  	end

  	def show
  		@giveaway = Giveaway.find(params[:id])
  	end

  	protected

  	def ensure_authorized
  		redirect_to sign_in_path unless giveaway_user.can_manage_giveaways?
  	end
  end
end
