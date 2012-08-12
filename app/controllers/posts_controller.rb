class PostsController < ApplicationController
  before_filter :authenticate_user!
  layout 'access'
  
  
  def index
    @posts = Post.all
  end
  
  def show
     @post = Post.find(params[:id])
     @images = Upload.where("post_id" == @post)
   end 
  
  def new
    index
      @post = Post.new
      @user_list = get_user_list
      @all_categories = get_all_categories
  end
  
  def edit 
      @post = Post.find(params[:id])
      @images = Upload.where("post_id" == @post)
      @user_list = get_user_list
      @all_categories = get_all_categories      
  end
  
  def create
    post_params = params[:post]
    user_id = post_params.delete(:user_id)
    #categories
    @all_categories = get_all_categories
    checked_categories = get_categories_from(params[:categories])
    removed_categories = @all_categories - checked_categories
    @post = Post.new(post_params)
    @post.author = User.find(user_id)
    if @post.save
      #categories
      checked_categories.each {|cat| @post.categories << cat if !@post.categories.include?(cat)}
      removed_categories.each {|cat| @post.categories.delete(cat) if @post.categories.include?(cat)}
      #flash
      flash[:notice] = "Post was successfully created."
      redirect_to :action => 'edit', :id => @post.id
    else
      @user_list = get_user_list 
      render :action => 'new'
    end
  end
  
  def update 
    post_params = params[:post]
    user_id = post_params.delete(:user_id)
    @all_categories = get_all_categories
    checked_categories = get_categories_from(params[:categories])
    removed_categories = @all_categories - checked_categories
    @post = Post.find(params[:id])
    @post.author = User.find(user_id) if @post.user_id != user_id
    if @post.update_attributes(post_params)
      checked_categories.each {|cat| @post.categories << cat if !@post.categories.include?(cat)}
      removed_categories.each {|cat| @post.categories.delete(cat) if @post.categories.include?(cat)}
      @perm = params[:permalink]
      flash[:notice] = "Post was successfully updated."
      redirect_to :action => 'edit', :id => @post
    else
      @user_list = get_user_list 
      render :action => 'edit', :id => @post
    end
  end

  def destroy
    @post = Post.find(params[:id]).destroy
    redirect_to :action => 'index'
  end
  
  def add_tag
    @post = Post.find(params[:id])
    @post.tag_list.add(params[:new_tag])
    @post.save
    redirect_to :action => 'edit', :id => @post 
    flash[:notice] = "tag added"
  end
  
  def remove_tag
    @post = Post.find(params[:id])
    @post.tag_list.remove(params[:tag])
    @post.save
    redirect_to :action => 'edit', :id => @post 
    flash[:notice] = "tag nuked"
  end
  
  private 
  
  def get_user_list
    return User.find(:all, :order => 'created_at ASC').collect {|user| [user.name, user.id]}
  end
  
  def get_all_categories
    return Category.find(:all, :order => 'name ASC')
  end
  
  def get_categories_from(cat_list)
    cat_list = [] if cat_list.blank?
    return cat_list.collect {|cid| Category.find_by_id(cid.to_i)}.compact
  end

end
