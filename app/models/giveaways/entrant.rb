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
  end
end
