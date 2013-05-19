class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :challenge_id
      t.text :comment

      t.timestamps
    end
  end
end
