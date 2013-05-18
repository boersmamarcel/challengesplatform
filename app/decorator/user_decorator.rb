class UserDecorator < Draper::Decorator
  delegate_all

  def fullname
    "#{object.firstname} #{object.lastname}"
  end

end
