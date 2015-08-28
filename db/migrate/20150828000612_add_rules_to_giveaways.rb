class AddRulesToGiveaways < ActiveRecord::Migration
  def change
    add_column :giveaways_giveaways, :rules, :text
  end
end
