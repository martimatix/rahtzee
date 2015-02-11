class UsersController < ApplicationController
  before_action :check_if_admin, :only => [:index]

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @user = User.find params[:id]
  end

  def edit
    @user = User.find params[:id]
  end

  def update
    user = User.find params[:id]
    user.update user_params
    redirect_to user
  end

  def index
    @users = User.all
  end

  def leaderboard
    @leaders = Game.where(filled: true).order(total_score: :desc, filled: :desc).limit(50)
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :country, :about_me, :password, :password_confirmation)
  end

  def check_if_admin
    redirect_to(root_path) unless @current_user.present? && @current_user.is_admin?
  end
end
