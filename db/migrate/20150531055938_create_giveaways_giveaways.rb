class CreateGiveawaysGiveaways < ActiveRecord::Migration
  def change
    create_table :giveaways_giveaways do |t|
      t.string :title
      t.text :description
      t.datetime :starts_at
      t.datetime :ends_at
      t.integer :number_of_prizes

      t.timestamps null: false
    end
  end
end
