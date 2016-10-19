class CreatePushCampaigns < ActiveRecord::Migration
  def change
    create_table :push_campaigns do |t|
      t.string    :name
      t.string    :message
      t.string    :target_age
      t.string    :target_gender
      t.string    :vendor
      t.string    :language
      t.boolean   :registered_users
      t.string    :ios_app_version
      t.string    :android_app_version
      t.datetime  :expire_at
      t.string    :time_to_live
      t.datetime  :delivery_at
    end
  end
end

