class MessagesController < ApplicationController
  
  before_filter :find_series
  before_filter :confirm_logged_in
  
  layout 'access'
    
  def index
    @series = Series.find(params[:series_id])
    @messages = Message.search(params[:search], params[:page])
  end
  
  def show
     @message = Message.find(params[:id])
  end 
  
  def new
    index
      @speaker_list = get_speaker_list
      @message = Message.new(:series_id => @series.id)
      @all_series = Series.order('start_date ASC')
  end
  
  def create
    message_params = params[:message]
    speaker_id = message_params.delete(:speaker_id)
    @message = Message.new(message_params)
    @message.speaker = Speaker.find(speaker_id)
    @message.series_id = params[:series_id]
    if @message.save
      if @message.featured_message == true
        Message.featured.where('id != ?', @message.id).update_all :featured_message => false 
      end
      flash[:notice] = 'Message "' + @message.title + '" was successfully created.'
      redirect_to :action => 'index', :series_id => @series.id
    else
      @speaker_list = get_speaker_list
      render :action => 'new'
    end
  end
   
  def edit 
    @speaker_list = get_speaker_list
    @message = Message.find(params[:id])
  end
    
  def update
    message_params = params[:message]
    speaker_id = message_params.delete(:speaker_id)
    @message = Message.find(params[:id])
    @message.speaker = Speaker.find(speaker_id) if @message.speaker_id != speaker_id
    if @message.update_attributes(message_params)
      if @message.featured_message == true
        Message.featured.where('id != ?', @message.id).update_all :featured_message => false 
      end
      flash[:notice] = 'The Message "' + @message.title + '" was successfully updated.'
      redirect_to :action => 'edit', :id => @message, :series_id => @series.id
    else
      @speaker_list = get_speaker_list
      render :action => 'edit'
    end
  end
  
  def destroy
    @message = Message.find(params[:id]).destroy
    flash[:notice] = "Message removed."
    redirect_to :action => 'index', :series_id => @series.id
  end
  
  def add_tag
    @message = Message.find(params[:id])
    @message.tag_list.add(params[:new_tag])
    @message.save
    redirect_to :action => 'edit', :id => @message, :series_id => @series.id
    flash[:notice] = "tag added"
  end
  
  def remove_tag
    @message = Message.find(params[:id])
    @series = Series.find(params[:series_id])
    @message.tag_list.remove(params[:tag])
    @message.save
    flash[:notice] = "tag nuked"
    redirect_to :action => 'edit', :id => @message.id, :series_id => @series.id
  end
  
  private 
  
  def get_speaker_list
    return Speaker.find(:all, :order => 'created_at ASC').collect {|speaker| [speaker.name, speaker.id]}
  end
  
  def find_series
    if params[:series_id]
      @series = Series.find_by_id(params[:series_id])
    end
  end
  
end
