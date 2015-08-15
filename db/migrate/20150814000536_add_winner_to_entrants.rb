class AddWinnerToEntrants < ActiveRecord::Migration
  def change
    add_column :giveaways_entrants, :winner, :boolean, default: false
  end
end
