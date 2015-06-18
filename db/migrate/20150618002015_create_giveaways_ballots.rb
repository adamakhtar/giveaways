class CreateGiveawaysBallots < ActiveRecord::Migration
  def change
    create_table :giveaways_ballots do |t|
      t.integer :entrant_id

      t.timestamps null: false
    end
    add_index :giveaways_ballots, :entrant_id
  end
end
