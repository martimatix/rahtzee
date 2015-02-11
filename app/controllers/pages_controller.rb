class PagesController < ApplicationController
  def home
    if @current_user.present?
      redirect_to games_new_path
    else
      @user = User.new
    end
  end

  def how_to_play
  end
end