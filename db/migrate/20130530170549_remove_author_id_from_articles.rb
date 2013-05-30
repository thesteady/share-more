class RemoveAuthorIdFromArticles < ActiveRecord::Migration
  def change
    remove_column :articles, :author_id
    remove_column :articles, :body
    add_column :articles, :published, :integer
  end
end
