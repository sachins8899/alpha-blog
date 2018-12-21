class ArticlesController < ApplicationController
  before_action :set_articles, only: [:update,:edit,:show,:destroy]
  before_action :require_user, except: [:index,:show]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  def new
    @article = Article.new
  end

  def create
    # render plain: params[:article].inspect
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:success] ="Article Was Successfully Added !"
      redirect_to article_path(@article)
    else
      flash[:danger] ="Somthing went wrong !! "
      render 'new'
    end
  end

  def update
    if @article.update(article_params)
      flash[:success] = "Article Updation Done !"
      redirect_to article_path(@article)
    else
      flash[:danger] = "Somthing went Wrong !!"
      render 'edit'
    end
  end

  def edit
  end

  def show
  end

  def index
    # @article = Article.all
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def destroy
    if(@article.destroy)
      flash[:success] = "Article Deleted Successfully !"
    else
      flash[:danger] = "Something went wrong !!"      
    end
    redirect_to articles_path
  end
  private
  
  def set_articles
    @article = Article.find(params[:id])
  end
  def article_params
    params.require(:article).permit(:title, :description)
  end
  
  def require_same_user
    if current_user != @article.user
      flash[:danger] = "You Can Only Edit Or Delete Your Own Article"
      redirect_to article_path
    end
  end
end