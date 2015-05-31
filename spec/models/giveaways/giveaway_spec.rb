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
  end
end
