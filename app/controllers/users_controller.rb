class UsersController < ApplicationController
  
  def new
    @user = User.new
  end
  
  def login
     @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success]="Successfully Added. Login with the user Name : #{@user.username}"
      redirect_to root_path
    else
      flash[:dengar]="Somthig wrong !! "
    end
  end
  
  
  private
  
  def user_params
    params.require(:user).permit(:username,:email, :first_name, :last_name, :password)
  end
end