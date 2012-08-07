class SpeakersController < ApplicationController
  
  before_filter :confirm_logged_in
  
  layout 'access'
    
  def index
    @speakers = Speaker.search(params[:search], params[:page])
    @speaker = Speaker.find(params[:id]) if params[:id]
    @speaker = Speaker.new if @speaker.nil?
  end
  
  def new 
    index
    render('index')
  end
  
  def show
    @speaker = Speaker.find(params[:id])
  end

  def create
    @speakers = Speaker.all
    @speaker = Speaker.new(params[:speaker])
    if @speaker.save
      flash[:notice] = 'Speaker was successfully created.'
      redirect_to :action => 'index'
    else
      render :action => 'index'
    end
  end

  def update
    @speakers = Speaker.all
    @speaker = Speaker.find(params[:id])
    if @speaker.update_attributes(params[:speaker])
      flash[:notice] = 'Speaker was successfully updated.'
      redirect_to :action => 'index'
    else
      render :action => 'index'
    end
  end

  def destroy
    Speaker.find(params[:id]).destroy
    redirect_to :action => 'index'
  end
end
