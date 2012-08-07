class AccessController < ApplicationController
  
  before_filter :confirm_logged_in, :except => [:index, :login, :send_login]  
  layout :choose_layout
  
  def index
    login
    render :action => 'login'
  end

  def login
  end
  
  def send_login
    found_user = User.authenticate(params[:username], params[:password])
    if found_user
      session[:user_id] = found_user.id
      session[:username] = found_user.username
      flash[:notice] = "You are now logged in."
      #change for home admin page
      redirect_to :controller => 'series', :action => 'index'
    else
      flash.now[:notice] = "Username/password combination incorrect. Please make sure caps lock key is off and try again."
      render :action => 'login'
    end
  end

  def dashboard
  end

  def logout
    session[:user_id] = nil
    session[:username] = nil
    flash[:notice] = "You are now logged out."
    redirect_to :action => 'login'
  end

  private
  
  def choose_layout    
    if [ 'login' ].include? action_name
      'login'
    elsif [ 'send_login'].include? action_name
      'login'
    else
      'access'
    end
  end
end
