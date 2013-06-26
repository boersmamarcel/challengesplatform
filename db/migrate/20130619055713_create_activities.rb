class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.text :description
      
      t.references :user

      t.timestamps
    end
  end
end
