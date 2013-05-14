class Enrollment < ActiveRecord::Base
  attr_accessible :challenge_id, :participant_id, :unenrolled_at
  validates_uniqueness_of :challenge_id, :scope => :participant_id

  belongs_to :participant, :class_name => 'User'
  belongs_to :challenge

  scope :enrolled, where('unenrolled_at IS NULL')

  def is_enrolled?
    unenrolled_at == nil
  end
  def unenroll
    self.unenrolled_at = DateTime.now
    self.save
  end
  def reenroll
    if is_enrolled? then
      raise "user is already enrolled for this challenge"
    else
      self.unenrolled_at = nil
      self.save
    end
  end

end
