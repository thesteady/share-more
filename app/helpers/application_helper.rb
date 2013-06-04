module ApplicationHelper

  def title
    "ShareMore"
  end

  def article_for(user)
    new_article_for(user)
  end

  def new_article_for(user)
    article = Article.new
    article.user = user
    article
  end
end
