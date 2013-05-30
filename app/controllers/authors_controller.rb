class AuthorsController < ApplicationController
  
  def index
    if current_user == Author.find_by_email("blair81@gmail.com")
      @authors = Author.all

      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @authors }
      end
    else
      redirect_to root_path
    end
  end

  def refresh
    current_user.expire_old_keys_and_build_new_key
    redirect_to authors_path
  end

  def show
    @author = current_user
  end

  def new
    @author = Author.new
  end

  def edit
    @author = current_user
  end

  def create
    @author = Author.new(params[:author])

    if @author.save
      auto_login(@author)
      redirect_to authors_path, notice: 'Author was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @author = Author.find(params[:id])

    if @author.update_attributes(params[:author])
      redirect_to authors_url, notice: 'Author was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @author = Author.find(params[:id])
    @author.destroy
    redirect_to authors_url
  end
end
