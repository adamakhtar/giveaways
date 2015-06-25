require_dependency "giveaways/application_controller"

module Giveaways
  class GiveawaysController < ApplicationController

  	before_action :ensure_admin

  	def index
  		@giveaways = Giveaway.all
  	end

  	def show
  	 @giveaway = load_giveaway
  	end

  	def new
      @giveaway = Giveaway.new(starts_at: Time.current, ends_at: 7.days.from_now)
  	end

    def create
      @giveaway = Giveaway.new(giveaway_params)

      if @giveaway.save
        flash[:success] = t('giveaways.giveaways.created')
        redirect_to @giveaway
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

    def giveaway_params
      params.require(:giveaway).permit(*giveaway_attributes)
    end

    def giveaway_attributes
      [
        :title, 
        :description, 
        :starts_at, 
        :ends_at, 
        :ballots_per_referral,
        :number_of_prizes,
        :thank_you_message,
        :email_subject,
        :email_from,
        :email_reply_to,
        :email_message,
      ]
    end

    def load_giveaway
      Giveaway.find(params[:id])
    end
  end
end
