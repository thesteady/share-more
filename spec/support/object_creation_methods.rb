module ObjectCreationMethods
  def new_author(overrides = {})
    defaults = {
      username: "username",
      email: "example@example.com"
    }
    Author.new(defaults.merge(overrides))
  end

  def create_author(overrides = {})
    author = new_author(overrides)
    author.save!
    author
  end

  def new_api_key(overrides = {})
    defaults = {
      expired: false
    }
    create_author.api_keys.new(defaults.merge(overrides))
  end

  def create_api_key(overrides = {})
    api_key = new_api_key(overrides)
    api_key.save!
    api_key
  end
end
