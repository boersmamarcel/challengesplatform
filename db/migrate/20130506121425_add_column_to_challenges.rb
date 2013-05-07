class AddColumnToChallenges < ActiveRecord::Migration
  def change
    add_column :challenges, :user_id, :integer
  end
end
