class Comment < ActiveRecord::Base
  attr_accessible :challenge_id, :comment, :user_id
  
  belongs_to :user
  belongs_to :challenge
  
  validates :comment, :length => {:minimum => 3, :message => "must have at least 3 characters"}
  validates :user_id, :presence => true
  validates :challenge_id, :presence => true
  
end
