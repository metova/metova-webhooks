class CreateMetovaWebhooks < ActiveRecord::Migration
  def change
    create_table :metova_webhooks do |t|
      t.references :user, index: true
      t.string :event
      t.string :url

      t.timestamps null: false
    end
    add_index :metova_webhooks, :event
  end
end
