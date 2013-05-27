module ProfileHelper

  def follows?(user)
    return false if current_user.nil?
    current_user.follows.include?(user)
  end
  
  def follower?(user)
    return false if current_user.nil?
    current_user.followers.include?(user)
  end
  
  def coparticipant?(user)
    return false if current_user.nil?
    
  end

end
