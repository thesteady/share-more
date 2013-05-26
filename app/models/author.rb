class Author < ActiveRecord::Base
  authenticates_with_sorcery!

  validates_uniqueness_of :username , :case_sensitive => false
  validates_uniqueness_of :email    , :case_sensitive => false
  
  validates_confirmation_of :password, :message => "should match confirmation", :if => :password
  
end
