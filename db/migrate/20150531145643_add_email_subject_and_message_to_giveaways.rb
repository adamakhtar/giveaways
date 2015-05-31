class AddEmailSubjectAndMessageToGiveaways < ActiveRecord::Migration
  def change
    add_column :giveaways_giveaways, :email_subject, :string
    add_column :giveaways_giveaways, :email_message, :text
  end
end
