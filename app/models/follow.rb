class Follow < ActiveRecord::Base
  attr_accessible :following_id, :user_id

  belongs_to :user
  belongs_to :follows, :class_name => "User", :foreign_key => 'user_id'
end
