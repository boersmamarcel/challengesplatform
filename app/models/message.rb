class Message < ActiveRecord::Base
  attr_accessible :body, :receiver_id, :is_read, :subject, :sender_id

  searchable do
    text :subject, :boost => 3
    text :sender do
      User.find(sender_id).fullname
    end
  end
  
  belongs_to :sender, :class_name => 'User'
  belongs_to :receiver, :class_name => 'User'
  
  scope :unread, where(:is_read => false)
  default_scope order('created_at DESC')

  scope :visible_for_user, lambda { |user|
    where(:receiver_id => user.id)
  }

  scope :search, lambda { |query|
    where do
      (subject =~ "%#{query}%")
    end  
  }

  # These functions originate from the decorator
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

    def img
      ActionController::Base.helpers.image_path("message-icon.png")
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
end