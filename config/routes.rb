Giveaways::Engine.routes.draw do

  root to: 'giveaways#index' 
  get 'confirm/:id', to: 'confirmations#update',  as: 'confirmation'
  get 'thank_you', to: 'confirmations#show', as: 'completed_confirmation'
  get 'invalid', to: 'confirmations#invalid', as: 'invalid_confirmation'

  resources :giveaways do
    resource :rules, only: :show
    resources :winners, only: [:index]
    resources :entrants, only: [:index] do
      collection { post :draw }
    end
    resource :entries, only: [:new, :create, :show]
  end

  get 'enter/:giveaway_id', to: 'entries#new', as: 'entry'
end