module Giveaways
  class Giveaway < ActiveRecord::Base
  	validates :title, :description, :starts_at, :ends_at, :number_of_prizes, presence: true
  end
end
