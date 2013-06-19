class AddColumnMeetingtimeToChallenge < ActiveRecord::Migration
  def change
    add_column :challenges, :meetingtime, :time
  end
end
