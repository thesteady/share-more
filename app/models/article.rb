class Article < ActiveRecord::Base
  attr_accessible :title, :published ,:revisions_attributes
  belongs_to :user

  has_many :revisions, :order => "created_at DESC"

  accepts_nested_attributes_for :revisions, :allow_destroy => true

  scope :published, where( :published => 1 )
  scope :drafts, where( :published => 0 )

  def body
    revisions.first.body
  end

end
