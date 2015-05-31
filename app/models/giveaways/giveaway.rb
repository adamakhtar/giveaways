module Giveaways
  class Giveaway < ActiveRecord::Base

  	has_many :entrants

  	validates :title, :description, :thank_you_message, :starts_at, :ends_at, :number_of_prizes, presence: true
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
