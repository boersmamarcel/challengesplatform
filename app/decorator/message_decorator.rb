class MessageDecorator < Draper::Decorator
  delegate_all
  
  def value
    subject
  end

  def url
    Rails.application.routes.url_helpers.message_path(id)
  end

  def sub
    #"To; #{receiver.decorate.fullname}"  if sender.id == current_user.id # once implemented
    "From; #{sender.decorate.fullname}" # unless sender.id == current_user.id
  end

  def type
    'M'
  end

  def img
    ActionController::Base.helpers.image_path("message-icon.png")
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
end