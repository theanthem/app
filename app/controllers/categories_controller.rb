class CategoriesController < ApplicationController
  
  before_filter :authenticate_user!  
  layout 'access'
    
  def index
    @categories = Category.all
    @category = Category.find(params[:id]) if params[:id]
    @category = Category.new if @category.nil?
  end
  
  def new 
    index
    render('index')
  end  
  
  def create
    @category = Category.new(params[:category])
    if @category.save
      flash[:notice] = 'Category was successfully created.'
      redirect_to :action => 'index'
    else
      render :action => 'index'
    end
  end

  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(params[:category])
      flash[:notice] = 'Category was successfully updated.'
      redirect_to :action => 'index'
    else
      render :action => 'index'
    end
  end

  def destroy
    Category.find(params[:id]).destroy
    redirect_to :action => 'index'
  end
end
