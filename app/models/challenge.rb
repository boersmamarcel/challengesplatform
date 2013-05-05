class Challenge < ActiveRecord::Base
  attr_accessible :count, :description, :end_date, :start_date, :state, :title
  scope :upcoming, where('start_date > ?', Date.today)
end
