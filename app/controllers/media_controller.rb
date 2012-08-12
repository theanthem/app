class MediaController < ApplicationController
  
  before_filter :authenticate_user!  
  layout 'access'
  
  def index
    @medias = Media.search(params[:search], params[:page])
  end
  
  def show
     @media = Media.find(params[:id])
  end

  def new
    index
      @media = Media.new
      @user_list = get_user_list
  end

  def edit
    @media = Media.find(params[:id])
    @user_list = get_user_list
  end
  
  def create
    post_params = params[:media]
    user_id = post_params.delete(:user_id)
    @media = Media.new(post_params)
    @media.author = User.find(user_id)
    if @media.save
      #flash
      flash[:notice] = "Media was successfully created."
      redirect_to :action => 'edit', :id => @media.id
    else
      @user_list = get_user_list 
      render :action => 'new'
    end
  end
  
  def update 
    post_params = params[:media]
    user_id = post_params.delete(:user_id)
    @media = Media.find(params[:id])
    @media.author = User.find(user_id) if @media.user_id != user_id
    if @media.update_attributes(post_params)
      @perm = params[:permalink]
      flash[:notice] = "Media was successfully updated."
      redirect_to :action => 'edit', :id => @media
    else
      @user_list = get_user_list 
      render :action => 'edit', :id => @media
    end
  end

  def destroy
    @media = Media.find(params[:id]).destroy
    redirect_to :action => 'index'
  end
  
  def add_tag
    @media = Media.find(params[:id])
    @media.tag_list.add(params[:new_tag])
    @media.save
    redirect_to :action => 'edit', :id => @media 
    flash[:notice] = "tag added"
  end
  
  def remove_tag
    @media = Media.find(params[:id])
    @media.tag_list.remove(params[:tag])
    @media.save
    redirect_to :action => 'edit', :id => @media 
    flash[:notice] = "tag nuked"
  end
  
  private 
  
  def get_user_list
    return User.find(:all, :order => 'created_at ASC').collect {|user| [user.name, user.id]}
  end
  
end
