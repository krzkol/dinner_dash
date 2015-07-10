class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = 'Successfully logged in'
      redirect_to root_path
    else
      flash[:danger] = 'Could not log in'
      render 'new'
    end
  end
end
