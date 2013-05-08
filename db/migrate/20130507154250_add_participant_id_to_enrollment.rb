class AddParticipantIdToEnrollment < ActiveRecord::Migration
  def change
    remove_column :enrollments, :user_id
    add_column :enrollments, :participant_id, :integer
  end
end
