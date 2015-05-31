Giveaways::Engine.routes.draw do
	resources :giveaways do
		resources :entrants, only: [:index, :new, :create]
	end
end
