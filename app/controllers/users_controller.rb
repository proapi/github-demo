require 'github/github_api'

class UsersController < ApplicationController

  before_filter :require_user

  def show
    if params[:id] && (current_user.id.eql?(params[:id].to_i) || current_user.login.eql?(params[:id]))
      @user = current_user
    end

    redirect_to(root_url, alert: 'Nie masz uprawnień do przeglądania tej strony!') unless @user
  end

  def edit
    current_user.repos.destroy_all if params[:wipeout]
    @repositories = Github::GithubAPI.repositories(current_user)
    @user = current_user
  end

  def update
    if current_user.update_attributes(user_params)
      redirect_to current_user, notice: 'Użytkownik zaktualizowany.'
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    session[:user_id] = nil
    redirect_to root_url, notice: 'Użytkownik usunięty.'
  end

  private

  def user_params
    params.require(:user).permit(:repos_attributes => [:name, :url, :public, :stargazers_count, :forks_count, :description])
  end
end
