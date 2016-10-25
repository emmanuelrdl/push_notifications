class AddSettingsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :settings, :text
    add_column :rpush_notifications, :push_campaign_id, :integer
  end
end
