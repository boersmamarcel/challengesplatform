class AddSupervisorIdToChallenge < ActiveRecord::Migration
  def change
    remove_column :challenges, :user_id
    add_column :challenges, :supervisor_id, :integer
  end
end
