class AddThankYouMessageToGiveaways < ActiveRecord::Migration
  def change
    add_column :giveaways_giveaways, :thank_you_message, :text
  end
end
