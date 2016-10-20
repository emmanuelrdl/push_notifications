class AddFieldstoPushCampaigns < ActiveRecord::Migration
  def change
    add_column :push_campaigns, :data, :text
    change_column :push_campaigns, :message, :text
  end
end
