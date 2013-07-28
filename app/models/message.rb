class Message < ActiveRecord::Base
  attr_accessible :body, :receiver_id, :is_read, :subject, :sender_id

  searchable do
    text :subject, :boost => 3
    text :sender do
      User.find(sender_id).firstname << " " << User.find(sender_id).lastname
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

end