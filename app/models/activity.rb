class Activity < ActiveRecord::Base
  attr_accessible :description
  
  belongs_to :user
  belongs_to :event, :polymorphic => true
end
