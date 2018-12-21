class SessionsController < ApplicationController
  def new 
    
  end
  
  def create
    user = User.find_by(email: params[:session][:email])
    if (user && user.authenticate(params[:session][:password]))
      session[:user_id] = user.id
      flash[:success] = "Wellcome, you have successfully loged in"
      redirect_to user_path(user)
    else
      flash.now[:danger] ="Wrong Login Information !!"
      render 'new'
    end
  end
  
  def destroy
    session[:user_id] = nil
    flash[:success] ="You have Loged Out !"
    redirect_to root_path
  end
end