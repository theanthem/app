class NewsController < ApplicationController
  
  before_filter :confirm_logged_in
  
  layout 'access'
  
  def index
    @newsItems = News.search(params[:search], params[:page]).sorted
  end
  
  def show
     @news = News.find(params[:id])
  end

  def new
    index
    @news = News.new
    @page_count = News.all.size + 1
  end

  def edit
    @news = News.find(params[:id])
    @page_count = News.all.size
  end
  
  def create
    @news = News.new(params[:news])
    @page_count = News.all.size + 1
    if @news.save
      #flash
      flash[:notice] = "News Items was successfully created."
      redirect_to :action => 'edit', :id => @news.id
    else
      render :action => 'new'
    end
  end
  
  def update 
    @news = News.find(params[:id])
    @page_count = News.all.size
    if @news.update_attributes(params[:news])
      @perm = params[:permalink]
      flash[:notice] = "News was successfully updated."
      redirect_to :action => 'edit', :id => @news
    else
      @user_list = get_user_list 
      render :action => 'edit', :id => @news
    end
  end

  def destroy
    @news = News.find(params[:id]).destroy
    redirect_to :action => 'index'
  end
  
  def add_tag
    @news = News.find(params[:id])
    @news.tag_list.add(params[:new_tag])
    @news.save
    redirect_to :action => 'edit', :id => @news 
    flash[:notice] = "tag added"
  end
  
  def remove_tag
    @news = News.find(params[:id])
    @news.tag_list.remove(params[:tag])
    @news.save
    redirect_to :action => 'edit', :id => @news 
    flash[:notice] = "tag nuked"
  end
  
end
