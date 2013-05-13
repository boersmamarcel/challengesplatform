module FollowHelper
  
  def is_following?(follower)
    current_user.follows.include?(follower)
  end
end
