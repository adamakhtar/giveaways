module Giveaways
  class GiveawayDraw < SimpleDelegator
    def self.perform(giveaway)
      giveaway_draw = new(giveaway)
      giveaway_draw.perform
    end

    def initialize(giveaway)
      super(giveaway)
    end

    def perform
      reset_winners
      winners = select_winners
    end

    private

    def reset_winners
      entrants.update_all(winner: false)
    end

    # TODO - implment a mysql, postgress specific method which utilizes their
    # own implementation of random at db level. Allow user to configure which method to 
    # use depending on their db setup. 
    # This whilst not efficient is database agnostic and a simple solution.
    def select_winners
      ballot_ids = ballots.pluck(:id).shuffle

      winner_ids = []
      ballot_ids.each do |id|
        break if winner_ids.size >= number_of_prizes
        entrant_id = Ballot.find(id).entrant_id
        winner_ids << entrant_id unless winner_ids.include? entrant_id
      end

      winning_entrants = Entrant.where(id: winner_ids)
      winning_entrants.update_all(winner: true)
      winning_entrants
    end
  end
end
