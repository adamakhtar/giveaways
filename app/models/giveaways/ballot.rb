module Giveaways
  class Ballot < ActiveRecord::Base
    belongs_to :entrant
  end
end
