class Challenge < ActiveRecord::Base
  # Supervisors have write access to these fields:
  attr_accessible :title, :description, :end_date, :start_date, :lead, :location, :commitment, :image,  :image_cache, :remove_image
  # But these are protected:
  attr_protected :count, :state

  belongs_to :supervisor, :class_name => "User"

  has_many :enrollments, :dependent => :destroy # Enrollments does not have a default scope for unenrolled users
  # Participants does has this default scope (See :conditions)
  has_many :participants, :through => :enrollments, :class_name => "User", :conditions => ("unenrolled_at IS NULL")
  has_many :comments, :order => 'updated_at DESC'

  validates :title, :presence => { :message => "One or more fields are missing" }, :if => :pending?
  validates :lead, :presence => { :message => "One or more fields are missing" }, :if => :pending?
  validates :lead, :length => { :in => 40..120 }, :if => :pending?
  validates :description, :presence => { :message => "One or more fields are missing" }, :if => :pending?
  validates :commitment, :numericality => {:only_integer => true, :greater_than_or_equal_to => 1, less_than_or_equal_to: 40}
  validates :start_date, :presence => { :message => "One or more fields are missing" }, :if => :pending?
  validates :end_date, :presence => { :message => "One or more fields are missing" }, :if => :pending?

  validate :dates, :if => :pending?
  scope :upcoming, where('start_date > ?', Date.today)
  scope :running, where('end_date > ? AND start_date < ?', Date.today, Date.today)
  scope :upcoming_and_running, where('end_date > ?', Date.today)
  scope :pending, where(:state => "pending")
  scope :proposal, where(:state => "proposal")
  scope :declined, where("state = ? AND count > ?", "proposal", 1)
  scope :approved, where(:state => "approved")
  # Edit for quick change of what is and is not editable
  scope :editable, where(:state => "proposal")
  scope :sorted_start_date, order('start_date ASC')
  
  scope :visible_for_user, lambda { |user|
    if user.is_admin?
      all
    elsif user.is_supervisor?
      where("state = 'approved' OR supervisor_id = ?", user.id)
    else
      where(:state => 'approved')
    end
  }

  # Carrierwave Image Uploading
  mount_uploader :image, ChallengeImageUploader

  def enroll(user)
    enrollment = enrollments.find_by_participant_id(user)
    if enrollment.present?
      enrollment.reenroll
    else
      Enrollment.create!(:challenge_id => self.id, :participant_id => user.id)
    end
  end

  def unenroll(user)
    enrollments.find_by_participant_id(user).unenroll
  end

  def pending?
    state == 'pending'
  end

  def running?
    Date.today.to_time_in_current_zone >= start_date && Date.today.to_time_in_current_zone <= end_date
  end

  def over?
    Date.today.to_time_in_current_zone >= end_date
  end

  def upcoming?
    Date.today.to_time_in_current_zone < start_date 
  end

  def editable_by_user?(user)
    (state == 'proposal' && user.id == supervisor_id) || user.is_admin?
  end

  def visible_for_user?(user)
   state == 'approved' || supervisor_id == user.id || user.is_admin?
  end

  def can_unenroll?
    !running?
  end

  def can_enroll?
    upcoming?
  end

  def to_declined
      self.state = "declined"
      self.count = count + 1
  end

  @protected

  def dates
    errors.add(:dates, "End date can not be before start date") if start_date.nil? || end_date.nil? || start_date > end_date
    errors.add(:dates, "Start date can not be in the past") if start_date.nil? || start_date < DateTime.now
  end
end
