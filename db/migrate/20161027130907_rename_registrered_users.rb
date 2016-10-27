class RenameRegistreredUsers < ActiveRecord::Migration
  def change
    rename_column :push_campaigns, :target_users, :target_registration_state
    rename_column :push_campaigns, :target_age, :target_users_age
    rename_column :push_campaigns, :target_gender, :target_users_gender
  end
end
