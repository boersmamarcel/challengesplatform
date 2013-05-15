class Challenge < ActiveRecord::Base
  attr_accessible :count, :description, :end_date, :start_date, :state, :title

  belongs_to :supervisor, :class_name => "User"

  has_many :enrollments, :dependent => :destroy # Enrollments does not have a default scope for unenrolled users
  # Participants does has this default scope (See :conditions)
  has_many :participants, :through => :enrollments, :class_name => "User", :conditions => ("unenrolled_at IS NULL")

  validates :title, :presence => { :message => "One or more fields are missing" }, :if => :pending?
  validates :description, :presence => { :message => "One or more fields are missing" }, :if => :pending?

  validates :start_date, :presence => { :message => "One or more fields are missing" }, :if => :pending?
  validates :end_date, :presence => { :message => "One or more fields are missing" }, :if => :pending?

  validate :dates, :if => :pending?
  scope :upcoming, where('start_date > ?', Date.today)
  scope :running, where('end_date > ? && start_date < ?', Date.today, Date.today)
  scope :upcoming_and_running, where('end_date > ?', Date.today)
  scope :pending, where(:state => "pending")
  scope :proposal, where(:state => "proposal")
  scope :declined, where("state = ? AND count > ?", "proposal", 1)
  scope :approved, where(:state => "approved")
  # Edit for quick change of what is and is not editable
  scope :editable, where(:state => "proposal")
  scope :running_first, order('start_date ASC')

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
  def editable_by_user?(user)
    (state == 'proposal' && user.id == supervisor_id) || user.is_admin?
  end

  def visible_for_user?(user)
   state == 'approved' || supervisor_id == user.id || user.is_admin?
  end
  @protected

  def dates
    errors.add(:dates, "End date can not be before start date") if start_date.nil? || end_date.nil? || start_date > end_date
    errors.add(:dates, "Start date can not be in the past") if start_date.nil? || start_date < DateTime.now
  end
end
