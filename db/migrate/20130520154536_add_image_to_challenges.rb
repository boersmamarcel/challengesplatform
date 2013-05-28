class AddImageToChallenges < ActiveRecord::Migration
  def change
    add_column :challenges, :image, :string
  end
end
