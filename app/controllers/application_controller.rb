class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'application'
  before_filter :authenticate_user!

  private

  def friend_url(friend)
    user_friend_url(friend.creator_id, friend)
  end
end
