require 'rails_helper'

module Giveaways
  RSpec.describe Giveaway, type: :model do
    it "is invalid without neccessary attributes" do
    	giveaway = Giveaway.new
    	giveaway.valid?
    	errors = giveaway.errors
    	expect(errors.keys).to include :title
      expect(errors.keys).to include :description
    	expect(errors.keys).to include :thank_you_message
    	expect(errors.keys).to include :starts_at
    	expect(errors.keys).to include :ends_at
    	expect(errors.keys).to include :number_of_prizes
    end

    it "ensures ends_at is later than starts_at" do
      giveaway = build(:giveaway, starts_at: 1.day.from_now, ends_at: 1.day.ago)
      expect(giveaway).to_not be_valid
      expect(giveaway.errors[:ends_at]).to eq ['must be later than the start date.']
    end

    describe "#in_progress?" do
      it "returns true when currently in_progress" do
        giveaway = Giveaway.new(starts_at: 1.day.ago, ends_at: 1.week.from_now)
        expect(giveaway.in_progress?).to be_truthy
      end

      it "returns false when already ended" do
        giveaway = Giveaway.new(starts_at: 5.days.ago, ends_at: 1.day.ago)
        expect(giveaway.in_progress?).to be_falsey
      end

      it "returns false when not yet started" do
        giveaway = Giveaway.new(starts_at: 5.days.from_now, ends_at: 2.weeks.from_now)
        expect(giveaway.in_progress?).to be_falsey
      end
    end
  end
end
