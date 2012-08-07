class SeriesController < ApplicationController

  before_filter :confirm_logged_in

  layout 'access'
    
  def index
    @all_series = Series.search(params[:search], params[:page])
  end
  
  def new
    index
    @series = Series.new
  end 
  
 def create
    @series = Series.new(params[:series])
    if @series.save
      if @series.featured_series == true
        Series.featured.where('id != ?', @series.id).update_all :featured_series => false 
      end
      flash[:notice] = 'Series was successfully created.'
      redirect_to :action => 'edit', :id => @series.id
    else
      render :action => 'new'
    end
  end
      
  def edit
    @series = Series.find(params[:id])
  end
  
  def update
    @series = Series.find(params[:id])
    if @series.update_attributes(params[:series])
      if @series.featured_series == true
        Series.featured.where('id != ?', @series.id).update_all :featured_series => false 
      end
      flash[:notice] = 'The Series "' + @series.title + '" was successfully updated.'
      redirect_to :action => 'edit', :id => @series.id
    else
      render :action => 'edit'
    end
  end
  
  def destroy # action should delete
    Series.find(params[:id]).destroy
    flash[:notice] = 'Series was successfully deleted.'
    redirect_to :action => 'index'
  end
  
end
