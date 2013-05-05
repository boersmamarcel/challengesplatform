class Challenge < ActiveRecord::Base
  attr_accessible :count, :description, :end_date, :start_date, :state, :title

  
  validates :title, :presence => { :message => "One or more fields are missing" }
  validates :description, :presence => { :message => "One or more fields are missing" }
  
  validates :start_date, :presence => { :message => "One or more fields are missing" }
  validates :end_date, :presence => { :message => "One or more fields are missing" }
  
  validate :dates
  scope :upcoming, where('start_date > ?', Date.today)


   def dates
     errors.add(:dates, "End date can not be before start date") if start_date.nil? || end_date.nil? || start_date > end_date
     errors.add(:dates, "Start date can not be in the past") if start_date.nil? || start_date < DateTime.now
   end
  

end
