module Giveaways
  class Entrant < ActiveRecord::Base

  	belongs_to :giveaway
    has_many :ballots, dependent: :destroy

  	validates :email, email: true, 
  										uniqueness: { 
  											scope: :giveaway_id, 
  											case_sensitive: false, 
  											message: 'has already been registered for this giveaway. Check your email for notification.' 
  										}

  	validates :first_name, :confirmation_token, :referral_token, presence: true

    after_initialize :set_tokens
    
    def self.confirm_email(token)
      if entrant = where(confirmation_token: token).take
        entrant.confirm_email!
        true
      else
        false
      end
    end

    def create_ballot
      ballots.create
    end

    def confirm_email!
      self.update_attributes(confirmed_email: true)
    end

    def ensure_confirmation_token
      self.confirmation_token ||= generate_token
    end

    def ensure_referral_token 
      self.referral_token ||= generate_token
    end

    def generate_token
      SecureRandom.urlsafe_base64
    end

    def send_email_confirmation
      EntrantMailer.confirm_email(id).deliver_later
    end

    def register
      transaction do 
        if save
          create_ballot
          send_email_confirmation
          true
        else
          false
        end
      end
    end

    def reward_referral(num_of_ballots)
      transaction do 
        num_of_ballots.times { ballots.build }
        save
      end
    end

    def set_tokens
      return if persisted?
      ensure_referral_token
      ensure_confirmation_token
    end
  end
end
