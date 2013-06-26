class Activity < ActiveRecord::Base
  attr_accessible :description
  
  belongs_to :user
  belongs_to :event, :polymorphic => true
  
  def self.delete_old_records
    self.where("created_at < :week", { :week => 1.week.ago }).destroy_all
  end
end
