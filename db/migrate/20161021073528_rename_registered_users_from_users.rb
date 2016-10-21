class RenameRegisteredUsersFromUsers < ActiveRecord::Migration
  def change
    rename_column :push_campaigns, :registered_users, :target_users
  end
end
