class CreateTokens < ActiveRecord::Migration
  def change
    create_table :tokens do |t|
      t.integer :push_token
      t.string  :vendor
      t.integer :user_id

    end
  end
end
