class HomeController < ApplicationController
  
  before_filter :confirm_logged_in
    
  def index
  end
end
