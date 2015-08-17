class AddNameToGiveaways < ActiveRecord::Migration
  def change
    add_column :giveaways_giveaways, :name, :string
    add_index :giveaways_giveaways, :name
  end
end
