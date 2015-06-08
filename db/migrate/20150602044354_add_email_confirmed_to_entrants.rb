class AddEmailConfirmedToEntrants < ActiveRecord::Migration
  def change
    add_column :giveaways_entrants, :confirmed_email, :boolean, default: false
    add_index  :giveaways_entrants, :confirmed_email
  end
end
