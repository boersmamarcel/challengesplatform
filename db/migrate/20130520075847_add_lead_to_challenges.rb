class AddLeadToChallenges < ActiveRecord::Migration
  def change
    add_column :challenges, :lead, :text
  end
end
