class Enrollment < ActiveRecord::Base
  attr_accessible :challenge_id, :user_id
  
  belongs_to :user
  belongs_to :challenge
end
