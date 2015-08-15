module Giveaways
  class Giveaway < ActiveRecord::Base

  	has_many :entrants, dependent: :destroy
    has_many :ballots, through: :entrants

  	validates :title, :description, :starts_at, :ends_at, :thank_you_message, presence: true
    validates :email_subject, :email_message, :email_from, presence: true
    validates :number_of_prizes, :ballots_per_referral, numericality: { only_integer: true, allow_nil: false }
    validates :email_reply_to, email: true
  	validate :starts_at_is_before_ends_at

    delegate :winners, to: :entrants, allow_nil: true, prefix: false

  	def in_progress?
  		(starts_at < Time.current) && (Time.current < ends_at)
  	end

    def closed?
      Time.current > ends_at
    end

  	def starts_at_is_before_ends_at
  		if (starts_at && ends_at && starts_at >= ends_at)
  			errors[:ends_at] << "must be later than the start date."
  		end
  	end
  end
end	
