class CreateGiveawaysEntrants < ActiveRecord::Migration
  def change
    create_table :giveaways_entrants do |t|
    	t.integer :giveaway_id
      t.string :first_name
      t.string :email
      t.integer :ballots, default: 0

      t.timestamps null: false
    end

    add_index :giveaways_entrants, :giveaway_id
  end
end
