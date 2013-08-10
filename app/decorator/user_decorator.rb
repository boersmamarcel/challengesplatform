class UserDecorator < Draper::Decorator
  delegate_all

  def fullname
      "#{firstname} #{lastname}"
    end

  def value
    fullname
  end

  def url
    Rails.application.routes.url_helpers.profile_user_path(id)
  end

  def sub
    if(tagline.eql?(nil) || tagline.length == 0)
      "-"
    else
      tagline
    end
  end

  def type
    'U'
  end

  def img
    Gravatar.new(email).image_url
  end

  def as_json(options={})
    super(
      options.merge(
        :root => false, 
        :only => [], 
        :methods => [:url, :value, :sub, :img, :type]
      )
    )
  end

  def activity_text
    h.link_to fullname, h.profile_user_path(object)
  end

end
