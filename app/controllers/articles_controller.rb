class ArticlesController < ApplicationController
  before_filter :require_login, :except => [:index, :show]
  # layout :layout_by_resource, :only => [:index]

  # def layout_by_resource
  #   if current_user.present?
  #     'application'
  #    else
  #     'landing'
  #   end
  # end

  def index
    if current_user.present?
      @articles = current_user.articles.all
      render :layout => 'application'
    else
      @articles = []
      render :layout => 'layouts/landing'
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

    @article.save

    redirect_to article_path(@article)
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
    @article.update_attributes(params[:article])

    flash[:message] = "Article '#{@article.title}' Updated!"

    redirect_to article_path(@article)
  end
end
