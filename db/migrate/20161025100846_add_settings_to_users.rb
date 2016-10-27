class AddSettingsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :settings, :text
    add_column :rpush_notifications, :push_campaign_id, :integer
    remove_column :push_campaigns, :name, :string
    remove_column :push_campaigns, :ios_app_version, :string
    remove_column :push_campaigns, :android_app_version, :string
  end
end
