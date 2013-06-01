class AddUniqueUrlToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :unique_url, :string
  end
end
