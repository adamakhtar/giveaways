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
      @entrant = EntrantRegistrar.register(@giveaway, entrant: entrant_params, referrel_token: params[:referral]) 
      
      if @entrant.valid?
        render :thank_you
      else
        render :new
      end
    end

    def confirm
      @giveaway = load_giveaway
      load_entrant_with_key do |entrant| 
        entrant.confirm_email!
      end
    end

  	protected

    def entrant_params
      params.require(:entrant).permit(:email, :first_name)
    end

    def load_referrer_with_key
      if entrant 
        yield entrant
      else
        render 'invalid_token'
      end
    end

    def load_entrant_with_key
      entrant = Entrant.find_by(giveaway: @giveaway, confirmation_token: params[:id], confirmed_email: false)
      if entrant 
        yield entrant
      else
        render 'invalid_token'
      end
    end

  	def load_giveaway
  		Giveaway.find(params[:giveaway_id])
  	end
  end
end
