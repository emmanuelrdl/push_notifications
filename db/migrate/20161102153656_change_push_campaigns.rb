class ChangePushCampaigns < ActiveRecord::Migration
  def change
    change_column :push_campaigns, :message, :text

  end
end
