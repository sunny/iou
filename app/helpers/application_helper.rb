module ApplicationHelper
  def friend_path(friend)
    user_friend_path(friend.creator_id, friend)
  end
  def edit_friend_path(friend)
    edit_user_friend_path(friend.creator_id, friend)
  end
end
