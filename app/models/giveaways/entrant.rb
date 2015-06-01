module Giveaways
  class Entrant < ActiveRecord::Base

  	belongs_to :giveaway

  	validates :email, email: true, 
  										uniqueness: { 
  											scope: :giveaway_id, 
  											case_sensitive: false, 
  											message: 'has already been registered for this giveaway. Check your email for notification.' 
  										}

  	validates :first_name, presence: true

    def register
      if save
        EntrantMailer.confirm_email(id).deliver_later
        true
      else
        false
      end
    end
  end
end
