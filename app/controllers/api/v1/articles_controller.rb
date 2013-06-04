class Api::V1::ArticlesController < ApplicationController
  def options
    @options = Article.options
    respond_to do |format|
      format.html {render inline: @options.to_json}
      format.json {render json: @options}
    end
  end

  def index
    @user = user_from_request 
    @articles = @user.articles
    render json: @articles
  end

  def show
    @article = Article.find_by_unique_url(params[:id])
    render json: @article
  end

  def create
    @article = user_from_request.articles.new(params[:article])
    
    if @article.save
      render json: @article
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  def user_from_request
    if key = ApiKey.find_by_access_token(params[:access_token])
      key.user
    else
      head 404, "not FOUND"
    end
  end

end
