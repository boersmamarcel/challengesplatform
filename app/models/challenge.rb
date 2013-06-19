class Challenge < ActiveRecord::Base

  # Supervisors have write access to these fields:
  attr_accessible :title, :description, :end_date, :start_date, :lead, :location, :commitment, :image,  :image_cache, :remove_image, :meetingtime
  # But these are protected:
  attr_protected :count, :state

  belongs_to :supervisor, :class_name => "User"

  has_many :enrollments, :dependent => :destroy # Enrollments does not have a default scope for unenrolled users
  # Participants does has this default scope (See :conditions)
  has_many :participants, :through => :enrollments, :class_name => "User", :conditions => ("unenrolled_at IS NULL")
  has_many :comments, :order => 'updated_at DESC'
  has_many :activities, :as => :event

  # Carrierwave Image Uploading
  mount_uploader :image, ChallengeImageUploader

  validates :title, :presence => { :message => "You need to supply a title" }
  validates :lead, :presence => { :message => "One or more fields are missing" }, :if => :pending?
  validates :lead, :length => { :in => 40..120 }, :if => :pending?
  validates :description, :presence => { :message => "One or more fields are missing" }, :if => :pending?
  validates :commitment, :numericality => {:only_integer => true, :greater_than_or_equal_to => 1, less_than_or_equal_to: 40}
  validates :start_date, :presence => { :message => "One or more fields are missing" }, :if => :pending?
  validates :end_date, :presence => { :message => "One or more fields are missing" }, :if => :pending?
  validate :dates, :if => :pending?
  validates :meetingtime, :presence => { :message => "You need to supply a first meeting time" }
  validates_processing_of :image

  scope :upcoming, where('start_date > ?', Date.today)
  scope :running, where('end_date >= ? AND start_date <= ?', Date.today, Date.today)
  scope :past, where('end_date < ?', Date.today)
  scope :upcoming_and_running, where('end_date > ?', Date.today)
  scope :pending, where(:state => "pending")
  scope :draft, where("state = 'draft' AND count < 2")
  scope :declined, where("state = 'draft' AND count > 1")
  scope :approved, where(:state => "approved")
  # Edit for quick change of what is and is not editable
  scope :editable, where(:state => "draft")
  scope :sorted_start_date, order('start_date ASC')
  scope :newest_first, order('start_date DESC')

  scope :visible_for_user, lambda { |user|
    if user.is_admin?

    elsif user.is_supervisor?
      where("state = 'approved' OR supervisor_id = ?", user.id)
    else
      where(:state => 'approved')
    end
  }

  scope :supervised_by_user, lambda { |user|
    where("supervisor_id = ?", user.id)
  }

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

  def draft?
      state == 'draft'
  end

  def declined?
      draft? and count > 1
  end
  
  def approved?
      state == 'approved'
  end

  def pending?
    state == 'pending'
  end

  def running?
    if end_date.present? && start_date.present?
      Date.today.to_time_in_current_zone >= start_date && Date.today.to_time_in_current_zone <= end_date
    else
      false
    end
  end

  def over?
    if end_date.present?
      Date.today.to_time_in_current_zone >= end_date
    else
      false
    end
  end

  def upcoming?
    if start_date.present?
      Date.today.to_time_in_current_zone < start_date
    else
      true
    end
  end

  def supervised_by_user?(user)
    supervisor_id == user.id
  end

  def editable_by_user?(user)
    (draft? && user.id == supervisor_id) || user.is_admin?
  end

  def visible_for_user?(user)
   state == 'approved' || supervisor_id == user.id || user.is_admin?
  end

  def can_unenroll?
    upcoming?
  end

  def can_enroll?
    upcoming?
  end

  def decline
      self.state = "draft"
      self.count = count + 1
  end

  @protected

  def dates
    errors.add(:dates, "End date can not be before start date") if start_date.nil? || end_date.nil? || start_date > end_date
    errors.add(:dates, "Start date can not be in the past") if start_date.nil? || start_date < DateTime.now
  end
end
