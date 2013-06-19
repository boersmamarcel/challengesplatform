class AddColumnToTableActivities < ActiveRecord::Migration
  def change
    change_table :activities do |t|
      t.references :event, :polymorphic => true
    end
  end
end
