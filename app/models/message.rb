class Message < ActiveRecord::Base
  attr_accessible :body, :receiver_id, :is_read, :subject, :sender_id
  
  belongs_to :sender, :class_name => 'User'
  belongs_to :receiver, :class_name => 'User'
  
  scope :unread, where(:is_read => false)
  default_scope order('created_at DESC')
  
end