module Giveaways
	class EntrantRegistrar
		def self.register(giveaway, params)
			new(giveaway, params).register
		end

		def initialize (giveaway, params)
			@giveaway = giveaway 
			@params   = params
		end

		def register
			entrant = build_entrant
		  
		  if entrant.register
		  	reward_referrer
		  end

		  entrant
		end

		private

		attr_reader :giveaway, :params

		def build_entrant
			giveaway.entrants.build(entrant_params)
		end

		def entrant_params
		  params[:entrant]
		end

		def load_referrer
			Entrant.find_by(referral_token: params[:referral_token])
		end

		def reward_referrer
			return unless referrer = load_referrer
			referrer.reward_referral(giveaway.ballots_per_referral)
		end
	end
end