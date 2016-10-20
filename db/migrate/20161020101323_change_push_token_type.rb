class ChangePushTokenType < ActiveRecord::Migration
  def change
    change_column :tokens, :push_token, :text
  end
end
