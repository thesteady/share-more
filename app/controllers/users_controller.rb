class UsersController < ApplicationController
  
  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update_attributes(params[:user])
      redirect_to root_path, notice: 'Succesfully was successfully updated.'
    else
      render action: "edit"
    end
  end

  def refresh
    current_user.expire_old_keys_and_build_new_key
    redirect_to root_path
  end

  def show
    @user = current_user
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
