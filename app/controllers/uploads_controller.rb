class UploadsController < ApplicationController
  
  def destroy
    @image = Upload.find(params[:id]).destroy
    redirect_to :controller => 'posts', :action => 'edit', :id => params[:post_id]
  end
  
end
