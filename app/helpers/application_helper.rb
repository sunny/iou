module ApplicationHelper
  def friend_path(friend)
    user_friend_path(friend.creator_id, friend)
  end
end
