class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'Account successfully created'
      redirect_to root_path
    else
      flash[:danger] = 'Could not create an account'
      render 'new'
    end
  end

  private
    def user_params
      params.require(:user).permit(:email, :first_name, :last_name, :display_name, :password, :password_confirmation)
    end
end
