class AddBallotsPerReferralToGiveaways < ActiveRecord::Migration
  def change
    add_column :giveaways_giveaways, :ballots_per_referral, :integer, default: 0
  end
end
