class UserDecorator < Draper::Decorator
  delegate_all

  def value
    fullname
  end

  def url
    Rails.application.routes.url_helpers.profile_user_path(id)
  end

  def sub
    tagline if defined? tagline
    "-" unless defined? tagline
  end

  def img
    Gravatar.new(email).image_url
  end

  def as_json(options={})
    super(
      options.merge(
        :root => false,
        :only => [],
        :methods => [:url, :value, :sub, :img]
      )
    )
  end

  def fullname
    "#{object.firstname} #{object.lastname}"
  end
  
  def activity_text
    h.link_to fullname, h.profile_user_path(object)
  end

end
