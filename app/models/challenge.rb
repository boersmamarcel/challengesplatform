class Challenge < ActiveRecord::Base
  attr_accessible :count, :description, :end_date, :start_date, :state, :title
  attr_accessor :submit

  belongs_to :supervisor, :class_name => "User", :foreign_key => "user_id"
  
  has_many :enrollments
  
  validate :submit?
  
  validates :title, :presence => { :message => "One or more fields are missing" }, :if => :submit?
  validates :description, :presence => { :message => "One or more fields are missing" }, :if => :submit?
  
  validates :start_date, :presence => { :message => "One or more fields are missing" }, :if => :submit?
  validates :end_date, :presence => { :message => "One or more fields are missing" }, :if => :submit?
  
  validate :dates, :if => :submit?
  scope :upcoming, where('start_date > ?', Date.today)
  scope :pending, where(:state => "pending")
  scope :proposal, where(:state => "proposal")
  scope :declined, where("state = ? AND count > ?", "proposal", 1)
  scope :approved, where(:state => "approved")
  # Edit for quick change of what is and is not editable
  scope :editable, where(:state => "proposal")
  
  @protected
  
  def submit?
      submit
  end

  def dates
    errors.add(:dates, "End date can not be before start date") if start_date.nil? || end_date.nil? || start_date > end_date
    errors.add(:dates, "Start date can not be in the past") if start_date.nil? || start_date < DateTime.now
  end
end