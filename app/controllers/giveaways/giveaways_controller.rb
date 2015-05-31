require_dependency "giveaways/application_controller"

module Giveaways
  class GiveawaysController < ApplicationController

  	before_action :ensure_authorized

  	def index
  		@giveaways = Giveaway.all
  	end

  	def show
  	 @giveaway = load_giveaway
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

    def edit
      @giveaway = load_giveaway
    end

    def update
      @giveaway = load_giveaway

      if @giveaway.update_attributes(giveaway_params)
        flash[:success] = t('giveaways.giveaways.updated')
        redirect_to @giveaway
      else
        render :edit
      end
    end

    def destroy
      @giveaway = load_giveaway
      @giveaway.destroy
      flash[:success] = t('giveaways.giveaways.destroyed')
      redirect_to giveaways_path
    end

  	protected

  	def ensure_authorized
  		redirect_to sign_in_path unless giveaway_user.can_manage_giveaways?
  	end

    def giveaway_params
      params.require(:giveaway).permit(:title, :description, :starts_at, :ends_at)
    end

    def load_giveaway
      Giveaway.find(params[:id])
    end
  end
end
