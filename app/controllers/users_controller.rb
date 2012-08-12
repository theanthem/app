class UsersController < ApplicationController 
  before_filter :authenticate_user!
  layout 'access'

  def index
    @users = User.all
  end

  def new
    index
    @user = User.new
  end
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = 'User was successfully created.'
      redirect_to :action => 'index'
    else
      render :action => 'edit'
    end
  end
  def edit
    @user = User.find(params[:id])
  end
  def update    
    if params[:commit] == "Update"
      @user = User.find(current_user.id)
      if params[:user][:password].blank?
        params[:user].delete(:password)
        params[:user].delete(:password_confirmation)
      end
      if @user.update_attributes(params[:user])
        flash[:notice] = 'User was successfully updated.'
        redirect_to :action => 'index'
      else
        render :action => 'edit'
      end
    end
  end
  
  def destroy # action should delete
    User.find(params[:id]).destroy
    flash[:notice] = 'User was successfully deleted.'
    redirect_to :action => 'index'
  end

end
