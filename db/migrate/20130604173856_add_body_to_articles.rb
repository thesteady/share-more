class AddBodyToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :body, :text
    drop_table :revisions
  end
end
