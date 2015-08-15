require 'rails_helper'

module Giveaways
  RSpec.describe GiveawayDraw, type: :model do
    describe "#perform" do
      it "draws specified number of winners" do
        entrants = create_list(:entrant, 3, :registered)
        giveaway = create(:giveaway, number_of_prizes: 2, entrants: entrants)

        winners = GiveawayDraw.perform(giveaway)

        expect(winners.size).to eq 2
      end

      it "does not allow an entrant to win twice" do
        entrant = create(:entrant)
        entrant.ballots << create_list(:ballot, 2) # Only 2 ballots and for same entrant
        giveaway = create(:giveaway, number_of_prizes: 1, entrants: [entrant]) # but only 1 prize

        winners = GiveawayDraw.perform(giveaway)

        expect(winners.size).to eq 1
      end

      it "resets previous winners" do
        entrant_a = create(:entrant, :registered, :winner)
        entrant_b = create(:entrant, :registered, :winner)
        giveaway = create(:giveaway, number_of_prizes: 1, entrants: [entrant_a, entrant_b])

        GiveawayDraw.perform(giveaway)

        expect(giveaway.winners.count).to eq 1
      end
    end
  end
end
  