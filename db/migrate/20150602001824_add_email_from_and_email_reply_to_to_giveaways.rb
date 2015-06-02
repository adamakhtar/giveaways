class AddEmailFromAndEmailReplyToToGiveaways < ActiveRecord::Migration
  def change
    add_column :giveaways_giveaways, :email_from, :string
    add_column :giveaways_giveaways, :email_reply_to, :string
  end
end
