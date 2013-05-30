module ApplicationHelper

  def title
    "TweetGists"
  end

  def new_article_for(user)
    article = Article.new
    article.user = user
    article
  end
end
