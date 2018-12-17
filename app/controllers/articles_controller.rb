class ArticlesController < ApplicationController
  def new
    @article = Article.new
  end

  def create
    # render plain: params[:article].inspect
    @article = Article.new(article_params)
    if @article.save
      flash[:notice] ="Article Was Successfully Added !"
      redirect_to article_path(@article)
    else
      flash[:error] ="Somthing went wrong !! "
      render 'new'
    end
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      flash[:notice] = "Article Updation Done !"
      redirect_to article_path(@article)
    else
      flash[:error] = "Somthing went Wrong !!"
      render 'edit'
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def show
    @article = Article.find(params[:id])
  end

  def index
    @article = Article.all
  end

  def destroy
    @article = Article.find(params[:id])
    if(@article.destroy)
      flash[:notice] = "Article Deleted Successfully !"
    else
      flash[:error] = "Something went wrong !!"      
    end
    redirect_to articles_path
  end
  private

  def article_params
    params.require(:article).permit(:title, :description)
  end
end