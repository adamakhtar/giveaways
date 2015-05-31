Giveaways::Engine.routes.draw do
	resources :giveaways do
		resources :entrants, only: [:index]
	end
end
