Giveaways::Engine.routes.draw do
	resources :giveaways do
		resources :entrants, only: [:index, :new, :create] do
		end
	end

	get 'giveaways/:giveaway_id/confirm/:key', to: 'entrants#confirm', as: 'confirm_giveaway_entrant'
end
