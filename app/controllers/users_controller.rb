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
      flash[:danger]="Somthig went wrong !! "
      render 'new'
    end
  end
  
  def edit
     @user = User.find(params[:id])
  end
  
  def show
    @user = User.find(params[:id])
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 3)
  end
  
  def index
    @users = User.paginate(page: params[:page], per_page: 3)
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success]="User was updated successfully !!"
      redirect_to articles_path
    else
      flash[:danger]="Somthig went wrong !! "
      render 'edit'
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:username,:email, :first_name, :last_name, :password)
  end
end