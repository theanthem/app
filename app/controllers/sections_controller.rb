class SectionsController < ApplicationController
  
  before_filter :confirm_logged_in
  before_filter :find_page
  layout 'access'
  
  def index
    @sections = Section.sorted.where(:page_id => @page.id)
  end

  def new
    @pages = Page.order('position ASC')
    @section = Section.new(:page_id => @page.id)
  end
  
  def create
    @pages = Page.order('position ASC')
    @section = Section.new(params[:section])
    if @section.save
      flash[:notice] = "Section successfully created."
      redirect_to :action => 'edit', :id => @section
    else
     @pages = Page.order('position ASC')
     flash[:notice] = "Section failed to create."
     render('new')
    end
  end

  def edit
    @page_count = Page.section.all.size + 1
    @pages = Page.order('position ASC')
    @section = Section.new(params[:section]) 
  end
  
  def update
    @section = Section.find(params[:id])
    if @page.update_attributes(params[:page])
      flash[:notice] = "Section was successfully updated."
      redirect_to :action => 'edit', :id => @section
    else
      @section_count = @page.sections.size
      @pages = Page.order('position ASC')
      render('edit')
    end    
  end

  def destroy
    @page = Page.find(params[:id]).destroy
    redirect_to :action => 'index'
  end
  
  def show
  end
  
  private 
  
  def find_page
     if params[:page_id]
       @page = Page.find_by_id(params[:page_id])
     end
  end
end
