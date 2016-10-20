class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :birthdate, :datetime
    add_column :users, :gender, :string
    add_column :users, :language, :string
    add_column :tokens, :language, :string
  end
end
