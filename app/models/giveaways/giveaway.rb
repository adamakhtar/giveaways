module Giveaways
  class Giveaway < ActiveRecord::Base

  	has_many :entrants

  	validates :title, :description, :thank_you_message, :starts_at, :ends_at, :number_of_prizes, presence: true

  	def in_progress?
  		(starts_at < Time.current) && (Time.current < ends_at)
  	end
  end
end	
