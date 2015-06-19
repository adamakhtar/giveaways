class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|

      t.boolean :giveaways_admin

      t.timestamps null: false
    end
  end
end
