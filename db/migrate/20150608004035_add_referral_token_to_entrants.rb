class AddReferralTokenToEntrants < ActiveRecord::Migration
  def change
    add_column :giveaways_entrants, :referral_token, :string
    add_index  :giveaways_entrants, :referral_token
  end
end
