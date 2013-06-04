module ApplicationHelper

  def title
    "ShareMore"
  end

  def article_for(user)
    last_revision_for(user) ||  new_article_for(user)
  end

  def last_revision_for(user)
    false
      # article = user.draft
      # article.revisions.build(body: user.draft.body)
      # article
  end

  def new_article_for(user)
    article = Article.new(published: 0)
    article.user = user
    article.revisions.build
    article
  end
end
