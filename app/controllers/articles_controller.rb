class ArticlesController < ApplicationController
  before_filter :require_login, :except => [:show]

  def index
    if limit = params[:limit]
      @articles = current_user.articles.limit(limit.to_i)
    else
      @articles = current_user.articles
    end
  end

  def show
    @article = Article.find_by_unique_url(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = current_user.articles.new(params[:article])
    
    if @article.save
      redirect_to root_path, notice: 'Successfully created'
    else
      redirect_to root_path, notice: "Sorry Bro."
    end
  end

  def destroy
    @article = Article.find_by_unique_url(params[:id])
    @article.destroy
    redirect_to root_path
  end

  def edit
    @article = Article.find_by_unique_url(params[:id])
  end

  def update
    @article = Article.find_by_unique_url(params[:id])
    if @article.update_attributes(params[:article])
      redirect_to root_path, notice: "updated"
    else
      redirect_to root_path, notice: "NAH PLAYA"
    end
  end
end
