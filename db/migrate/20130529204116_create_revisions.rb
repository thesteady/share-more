class CreateRevisions < ActiveRecord::Migration
  def change
    create_table :revisions do |t|
      t.text :body
      t.integer :article_id
      t.integer :published

      t.timestamps
    end
    add_index :revisions, :article_id
  end
end
