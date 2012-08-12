class CommentsController < ApplicationController
  
  before_filter :authenticate_user!  
  layout 'access'
  
  def index
    case params[:status]
    when 'approved'
       @comments = Comment.paginate :per_page => 10, :page => params[:page],:conditions => "status = 'approved'"
    when 'spam'
       @comments = Comment.paginate :per_page => 10, :page => params[:page],:conditions => "status = 'spam'"
    when 'all'
       @comments = Comment.paginate :per_page => 10, :page => params[:page]
    else 
       @comments = Comment.paginate :per_page => 10, :page => params[:page], :conditions => "status = 'new'"
    end  
  end

  def show
    @comment = Comment.find(params[:id])
  end
  
  def edit
    
  end
  
  def destroy
    @comment = Comment.find(params[:id]).destroy
    redirect_to :action => 'index'
  end
  
  def set_status
    begin
      status = params[:commit] || ""
      checked_items = params[:commentlist]
      checked_items.each do |id|
        Comment.update(id.to_i, :status => status.downcase)
      end
      flash[:notice] = "The checked items have been updated."
      redirect_to(:action => 'index')
    rescue
      flash[:notice] = "An unknown error ocurred."
      redirecet_to(:action => 'index')
    end
  end
  
end
