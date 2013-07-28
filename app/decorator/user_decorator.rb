class UserDecorator < Draper::Decorator
  delegate_all

  def activity_text
    h.link_to fullname, h.profile_user_path(object)
  end

end
