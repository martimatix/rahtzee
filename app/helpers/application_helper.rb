module ApplicationHelper
  def nav_menu
    links = "<li>#{ link_to('How to play', how_to_play_path) }</li>"
    links += "<li>#{ link_to('Leaderboard', leaderboard_path) }</li>"
    links += "<li>#{ link_to('About', about_path) }</li>"

    if @current_user.present?
      if @current_user.is_admin
        link += "<li>#{ link_to('All users', users_path)}</li>"
      end
      links += "<li>#{ link_to('My profile', @current_user) }</li>"
      links += "<li>#{ link_to('Sign out ' + @current_user.name, login_path, :method => :delete) }</li>"
    end
    links
  end
end
