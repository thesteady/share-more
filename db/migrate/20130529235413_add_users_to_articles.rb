class AddUsersToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :user_id, :integer
    add_index :articles, :user_id
    add_column :api_keys, :user_id, :integer
    add_index :api_keys, :user_id
  end
end
