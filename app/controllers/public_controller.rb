class PublicController < ApplicationController
  
  def index
    home
    render(:action => 'home')
  end
  
  def home
    @featured_series = Series.visible.featured.sorted.last
    @current_series = Series.visible.sorted.last
    @featured_message = Message.published.featured.sorted.last
    @current_message = Message.published.sorted.last
  end
  
  def archive
    @all_series = Series.visible.sorted.reverse
    @featured = Series.visible.featured.sorted.last
    @current = Series.visible.sorted.last
  end
  
  def series
    @series = Series.where(:permalink => params[:series_id]).last
  end
  
  def message
    @series = Series.where(:permalink => params[:series_id]).last
    @message = Message.where(:permalink => params[:id], :series_id => @series).first
    impressionist(@message)
    @related = @message.find_related_tags.limit(3)
  end
  
  def page
    @page_id = Page.where(:permalink => params[:id]).published.first
    if @page_id.root?
      @page = @page_id
    else
      @page = Page.where(:permalink => params[:id], :parent_id => params[:parent_id])
    end
    redirect_to(:action => '404') unless @page
  end
  
  def blog
    @posts = Post.published(:order => 'published_at DESC')
  end

  def show
  end
end
