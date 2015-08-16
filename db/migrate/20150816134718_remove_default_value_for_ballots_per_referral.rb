class RemoveDefaultValueForBallotsPerReferral < ActiveRecord::Migration
  def up
    change_column_default :giveaways_giveaways, :ballots_per_referral, nil
  end

  def down
    change_column_default :giveaways_giveaways, :ballots_per_referral, 0
  end
end
