class RemoveBallotsFromEntrants < ActiveRecord::Migration
  def up
    remove_column :giveaways_entrants, :ballots
  end

  def down
    add_column :giveaways_entrants, :ballots, :integer, default: 0
  end
end
