module ProfileHelper

  def follows?
    return false if current_user.nil?
    current_user.follows.include?(@user)
  end

end
