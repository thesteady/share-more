class Article < ActiveRecord::Base
  attr_accessible :title, :revision_attributes
  belongs_to :user


  has_one :revision
  accepts_nested_attributes_for :revision, :allow_destroy => true

  def body
    revision.body
  end

end
