class AddLocationToChallenges < ActiveRecord::Migration
  def change
    add_column :challenges, :location, :text
  end
end
