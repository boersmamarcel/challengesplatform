class CreateChallenges < ActiveRecord::Migration
  def change
    create_table :challenges do |t|
      t.string :title
      t.text :description
      t.timestamp :start_date
      t.timestamp :end_date
      t.string :state, :default => proposal
      t.integer :count, :default => 1

      t.timestamps
    end
  end
end
