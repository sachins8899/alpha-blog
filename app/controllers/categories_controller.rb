class CategoriesController < ApplicationController
  def index
    @categories = Category.all.paginate(page: params[:page],per_page: 6)
  end
  def new
    @category = Category.new
  end
  
  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] ="Category Added Successfully !!"
      redirect_to articles_path
    else
      flash[:danger] ="Somthing Went Wrong !!"
      render 'new'
    end
  end
  
  def show
    @category = Category.find(params[:id])
    @category_articles = @category.articles.paginate(page: params[:page],per_page: 3)
  end
  
  def destroy
    @category = Category.find(params[:id])
    if @category.destroy
      flash[:success] ="Category Deleted Successfully !!"
      redirect_to categories_path
    else
       flash[:danger] ="Somthing Went Wrong !!"
       render 'index'
    end
  end
  
  private
  def category_params
    params.require(:category).permit(:name)
  end
end