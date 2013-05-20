class AddCommitmentToChallenges < ActiveRecord::Migration
  def change
    add_column :challenges, :commitment, :integer
  end
end
