module ObjectCreationMethods
  def new_user(overrides = {})
    defaults = {
      username: "username",
      email: "example@example.com"
    }
    User.new(defaults.merge(overrides))
  end

  def create_user(overrides = {})
    user = new_user(overrides)
    user.save!
    user
  end

  def new_api_key(overrides = {})
    defaults = {
      expired: false
    }
    create_user.api_keys.new(defaults.merge(overrides))
  end

  def create_api_key(overrides = {})
    api_key = new_api_key(overrides)
    api_key.save!
    api_key
  end
end
