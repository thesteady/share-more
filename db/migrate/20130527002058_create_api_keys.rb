class CreateApiKeys < ActiveRecord::Migration
  def change
    create_table :api_keys do |t|
      t.string :access_token
      t.integer :author_id
      t.boolean :expired

      t.timestamps
    end
  end
end
