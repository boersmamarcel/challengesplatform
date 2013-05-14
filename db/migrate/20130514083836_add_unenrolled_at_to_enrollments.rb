class AddUnenrolledAtToEnrollments < ActiveRecord::Migration
  def change
    add_column :enrollments, :unenrolled_at, :datetime
  end
end
