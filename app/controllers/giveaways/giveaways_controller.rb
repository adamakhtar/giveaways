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

  	def new
  	end

    def create
      @giveaway = Giveaway.new(giveaway_params)

      if @giveaway.save
        flash[:success] = t('giveaways.giveaways.created')
        redirect_to giveaway
      else
        render :new
      end
    end

  	protected

  	def ensure_authorized
  		redirect_to sign_in_path unless giveaway_user.can_manage_giveaways?
  	end

    def giveaway_params
      params.require(:giveaway).permit(:title, :description, :starts_at, :ends_at)
    end
  end
end
