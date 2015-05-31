require 'rails_helper'

module Giveaways
  RSpec.describe Entrant, type: :model do
    it "validates name and email" do
    	entrant = Entrant.new
 			entrant.valid?
    	expect(entrant.errors).to include :email
    	expect(entrant.errors).to include :first_name
    end

    it "validates email address is unique for parent giveaway" do
    	giveaway = create(:giveaway)
    	entrant = create(:entrant, email: 'bob@example.com', giveaway: giveaway)
    	cheater = build(:entrant, email: 'bob@example.com', giveaway: giveaway)

    	expect(cheater).to_not be_valid
    	expect(cheater.errors.full_messages).to include 'Email has already been registered for this giveaway. Check your email for notification.'
    end
  end
end
