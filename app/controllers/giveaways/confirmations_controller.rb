require_dependency "giveaways/application_controller"

module Giveaways
  class ConfirmationsController < ApplicationController
    layout Giveaways.public_layout

    # GET method to allow users to confirm via link in email
    def update
      load_entrant_with_key do |entrant| 
        entrant.confirm_email!        
        redirect_to completed_confirmation_path
      end
    end

    def show
      # Entry confirmation
    end

    def invalid
    end

    protected

    def load_entrant_with_key
      entrant = Entrant.find_by(confirmation_token: params[:id], confirmed_email: false)
      if entrant 
        yield entrant
      else
        redirect_to invalid_confirmation_path
      end
    end
  end
end
