class Challenge < ActiveRecord::Base
  attr_accessible :count, :description, :end_date, :start_date, :state, :title
  attr_accessor :submit
  
  
  validate :submit?
  
  validates :title, :presence => { :message => "One or more fields are missing" }, :if => :submit?
  validates :description, :presence => { :message => "One or more fields are missing" }, :if => :submit?
  
  validates :start_date, :presence => { :message => "One or more fields are missing" }, :if => :submit?
  validates :end_date, :presence => { :message => "One or more fields are missing" }, :if => :submit?
  
  validate :dates, :if => :submit?
  scope :upcoming, where('start_date > ?', Date.today)
  scope :pending, where(:state => "pending")
  scope :proposal, where(:state => "proposal")
  scope :declined, where(:state => "declined")
  scope :approved, where(:state => "approved")
  
  @protected
  
  def submit?
      submit
  end


   def dates
     errors.add(:dates, "End date can not be before start date") if start_date.nil? || end_date.nil? || start_date > end_date
     errors.add(:dates, "Start date can not be in the past") if start_date.nil? || start_date < DateTime.now
   end
  

end
