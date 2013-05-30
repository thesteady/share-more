class ArticlesController < ApplicationController
  # before_filter :require_login, :only => [:index]
  
  def index
    if current_user == nil
      @articles = []
      render :layout => 'layouts/landing'
    else
      @articles = current_user.articles.published

      render :layout => 'application'
    end

  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = current_user.articles.new(params[:article])
    if params[:save_revision]
      @article.published = 0
    else
      @article.published = 1
    end
    @article.save
    
    redirect_to root_path
  end

  def destroy
    @article = Article.find(params[:id])

    @article.destroy

    redirect_to articles_path
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if params[:save_revision]
      @article.published = 0
    else
      @article.published = 1
    end

    @article.save
    @article.update_attributes(params[:article])

    flash[:message] = "Article '#{@article.title}' Updated!"

    redirect_to root_path
  end
end
