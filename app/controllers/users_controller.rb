require 'Github/github_api'
class UsersController < ApplicationController

  before_filter :require_user, except: :new

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if current_user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to current_user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end

  def import
    current_user.repos.destroy_all if params[:wipeout]
    @repositories = Github::API.repositories(current_user)
  end

  private

  def user_params
    params.require(:user).permit(:repos_attributes => [:name, :url, :public, :stargazers_count, :forks_count])
  end
end
