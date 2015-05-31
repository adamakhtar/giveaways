Giveaways::Engine.routes.draw do
	resources :giveaways, only: [:index]
end
