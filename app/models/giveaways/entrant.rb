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

    after_initialize :set_confirmation_token

    def self.confirm_email(token)
      if entrant = where(confirmation_token: token).take
        entrant.confirm_email!
        true
      else
        false
      end
    end

    def confirm_email!
      self.update_attributes(confirmed_email: true)
    end

    def register
      if save
        EntrantMailer.confirm_email(id).deliver_later
        true
      else
        false
      end
    end

    def set_confirmation_token
      return if persisted?
      self.confirmation_token ||= SecureRandom.urlsafe_base64
    end
  end
end
