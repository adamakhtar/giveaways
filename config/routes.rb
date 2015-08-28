Giveaways::Engine.routes.draw do
	resources :giveaways do
    resource :rules, only: :show
    resources :winners, only: [:index]
		resources :entrants, only: [:index, :new, :create] do
      collection { post :draw }
		end
	end

  get 'enter/:giveaway_id', to: 'entrants#new', as: 'entry'

  get 'thank_you/:giveaway_id', to: 'entrants#thank_you', as: 'thank_you'

	get 'giveaways/:giveaway_id/confirm/:key', to: 'entrants#confirm', as: 'confirm_giveaway_entrant'
end
