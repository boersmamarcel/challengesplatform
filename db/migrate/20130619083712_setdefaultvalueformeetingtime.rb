class Setdefaultvalueformeetingtime < ActiveRecord::Migration
  def change
    change_column_default :challenges, :meetingtime, "12:00:00"
  end
end
