module UserHelper
  def current_user
    @current_user = User.find(session[:user_id]) if session[:user_id]
  end

  def authenticate_user
    unless user_logged_in?
      flash[:danger] = 'You must be logged in to perform this action'
      redirect_to login_path
    end
  end

  def user_logged_in?
    !!current_user
  end
end
