class Revision < ActiveRecord::Base
  attr_accessible :article_id, :body, :published
end
