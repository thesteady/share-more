class Revision < ActiveRecord::Base
  attr_accessible :article_id, :body, :published

  belongs_to :article
end
