class UsersController < ApplicationController
  
  before_action :set_user , only: [:edit, :show ,:update]
  before_action :require_same_user, only:[:edit, :update] 
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success]="Successfully Added. Login with the user Name : #{@user.username}"
      redirect_to root_path
    else
      flash[:danger]="Somthig went wrong !! "
      render 'new'
    end
  end
  
  def edit
  end
  
  def show
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 3)
  end
  
  def index
    @users = User.paginate(page: params[:page], per_page: 3)
  end
  
  def update
    if @user.update(user_params)
      flash[:success]="User was updated successfully !!"
      redirect_to articles_path
    else
      flash[:danger]="Somthig went wrong !! "
      render 'edit'
    end
  end
  def destroy
    @user = User.find(params[:id])
    if current_user != @user
      if @user.destroy 
        flash[:success]="User Deleted Successfully !!"
        redirect_to users_path
      end
    else
      flash[:danger] ="Can't Delete this User"
      redirect_to root_path
    end
  end
  
  private
  
  def set_user
    @user  = User.find(params[:id])
  end
  def user_params
    params.require(:user).permit(:username,:email, :first_name, :last_name, :password)
  end
  def require_same_user
    if current_user != @user
      flash[:danger] ="You Can Oly Edit Ypur Own Account"
      redirect_to root_path
    end
  end
end