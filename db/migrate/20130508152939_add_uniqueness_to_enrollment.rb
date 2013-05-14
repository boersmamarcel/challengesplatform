class AddUniquenessToEnrollment < ActiveRecord::Migration
  def change
    add_index :enrollments, [:challenge_id, :participant_id], :unique => true
  end
end
