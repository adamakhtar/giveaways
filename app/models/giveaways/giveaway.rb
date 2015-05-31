module Giveaways
  class Giveaway < ActiveRecord::Base

  	has_many :entrants

  	validates :title, :description, :starts_at, :ends_at, :number_of_prizes, presence: true
  end
end
