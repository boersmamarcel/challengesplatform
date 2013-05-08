class Enrollment < ActiveRecord::Base
  attr_accessible :challenge_id, :participant_id
  validates_uniqueness_of :challenge_id, :scope => :participant_id

  belongs_to :participant, :class_name => 'User'
  belongs_to :challenge
end
