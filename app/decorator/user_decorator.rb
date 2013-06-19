class UserDecorator < Draper::Decorator
  delegate_all

  def fullname
    "#{object.firstname} #{object.lastname}"
  end
  
  def activity_text
    h.link_to fullname, h.profile_user_path(object)
  end

end
