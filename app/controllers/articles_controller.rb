class ArticlesController < ApplicationController
  before_filter :require_login, :except => [:show]

  def index
    if limit = params[:limit]
      @articles = current_user.articles.published.limit(limit.to_i)
    else
      @articles = current_user.articles.published.includes(:revisions)
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @articles }
    end
  end

  def show
    @article = Article.find_by_unique_url(params[:id])
   
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @article }
    end
  end

  def new
    @article = Article.new
  end

  def create
    @article = current_user.articles.new(params[:article])
    @article.published = 1
    
    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Successfully created.' }
        format.json { render json: @article }
      else
        format.html { redirect_to root_path, notice: "Sorry Bro." }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @article = Article.find(params[:id])

    @article.destroy

    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { head :no_content }
    end
  end

  def edit
    @article = Article.find_by_unique_url(params[:id])
  end

  def update
    @article = Article.find_by_unique_url(params[:id])

    if params[:save_revision]
      @article.published = 0
    else
      @article.published = 1
    end

    @article.save
    @article.update_attributes(params[:article])

    redirect_to root_path
  end
end
