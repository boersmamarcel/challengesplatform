class MessageDecorator < Draper::Decorator
  delegate_all

  def value
    subject
  end

  def url
    Rails.application.routes.url_helpers.message_path(id)
  end

  def as_json(options={})
    super(
      options.merge(
        :root => false, 
        :only => [:id, :title], 
        :methods => [:url, :value]
      )
    )
  end
end