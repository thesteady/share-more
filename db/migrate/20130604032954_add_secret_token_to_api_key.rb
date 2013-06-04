class AddSecretTokenToApiKey < ActiveRecord::Migration
  def change
    add_column :api_keys, :secret_token, :string
  end
end
