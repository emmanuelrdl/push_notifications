class ChangePushCampaign < ActiveRecord::Migration
  def change
    change_column :push_campaigns, :registered_users, :string
  end
end
