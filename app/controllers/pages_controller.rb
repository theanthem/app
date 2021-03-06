class PagesController < ApplicationController
  
  before_filter :authenticate_user!
  before_filter :find_parent
  layout 'access'
  
  def index
     @pages = Page.sorted.roots.search(params[:search], params[:page])
  end
  
  def show
    @page = Page.find(params[:id])
  end 
  
  def new
    if params[:parent_id]
      @page = Page.new(:parent_id => :parent_id)
      @page_count = Page.find(params[:parent_id]).children.size + 1
    else
      @page = Page.new
      @page_count = Page.roots.sort_by(&:position).size + 1
    end
  end
  
  def create
    @page = Page.new(params[:page])
    if @page.save
      @page.insert_at(@page.position)
      flash[:notice] = "Page was successfully created."
      redirect_to :action => 'edit', :id => @page
    else
      @page_count = Page.roots.sort_by(&:position).size + 1
      @parents = Page.roots.sort_by(&:position)
      flash[:notice] = "Page was faield to be created."
      render('new')
    end
  end
    
  def edit
    @page = Page.find(params[:id])
    if @page.root? # Position for root pages
      @page_count = Page.roots.sort_by(&:position).size
    else @page.child? # Position for children pages
      @page_count = @page.self_and_siblings.sort_by(&:subposition).size
    end
  end
  
  def update  
    @page = Page.find(params[:id])
    if @page.update_attributes(params[:page])
      if @page.root?
        @page.insert_at(@page.position)
        @page.subposition = 0
      else 
        @page.position = @page.parent.position
      end
      flash[:notice] = "Page was successfully updated."
      redirect_to :action => 'edit', :id => @page
    else
      if @page.root? # Position for root pages
        @page_count = Page.roots.sort_by(&:position).size
      else @page.child? # Position for children pages
        @page_count = @page.self_and_siblings.sort_by(&:subposition).size
      end
      render('edit')
    end
  end

  def destroy
    @page = Page.find(params[:id]).destroy
    redirect_to :action => 'index'
  end
  
  private 
  
  def find_parent
     if params[:parent_id]
       @parent = Page.find_by_id(params[:parent_id])
     end
   end
end
