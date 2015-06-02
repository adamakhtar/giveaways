module Giveaways
  class Giveaway < ActiveRecord::Base

  	has_many :entrants

  	validates :title, :description, :starts_at, :ends_at, presence: true
    validates :thank_you_message, :number_of_prizes, presence: true
    validates :email_subject, :email_message, :email_from, presence: true
    validates :email_reply_to, email: true
  	validate :starts_at_is_before_ends_at

  	def in_progress?
  		(starts_at < Time.current) && (Time.current < ends_at)
  	end

  	def starts_at_is_before_ends_at
  		if (starts_at && ends_at && starts_at >= ends_at)
  			errors[:ends_at] << "must be later than the start date."
  		end
  	end
  end
end	
