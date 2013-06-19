class UpdateExistingChallengesToAddMeetingTime < ActiveRecord::Migration
  def change
    Challenge.where(:meetingtime => nil).all.each do |c|
      c.update_attribute :meetingtime, "12:00:00"
    end
  end
end
