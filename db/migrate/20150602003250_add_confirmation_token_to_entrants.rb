class AddConfirmationTokenToEntrants < ActiveRecord::Migration
  def change
    add_column :giveaways_entrants, :confirmation_token, :string
    add_index  :giveaways_entrants, :confirmation_token
  end
end
