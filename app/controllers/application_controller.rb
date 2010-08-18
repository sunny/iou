class Error404 < StandardError
end

class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'application'
  before_filter :authenticate_user!

  rescue_from Error404, :with => :render_404
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404

  protected

  def render_404
    respond_to do |format|
      format.html { render :file => "#{Rails.root}/public/404.html", :status => '404 Not Found' }
      format.xml  { render :nothing => true, :status => '404 Not Found' }
    end
  end
end
