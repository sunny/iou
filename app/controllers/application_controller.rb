class Error404 < StandardError
end

class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'application'
  before_filter :authenticate_user!

  rescue_from Error404, :with => :render_404
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404
  rescue_from ActionController::RoutingError, :with => :rescue_404


  protected

  def render_404
    respond_to do |format|
      format.html { render :file => "#{Rails.root}/public/404.html", :status => '404 Not Found' }
      format.xml  { render :nothing => true, :status => '404 Not Found' }
    end
  end

  def current_user_friend
    if params[:id] =~ /^[0-9]+$/
      current_user.friends.find params[:id]
    else
      current_user.friends.find_by_name! params[:id]
    end
  end
end
