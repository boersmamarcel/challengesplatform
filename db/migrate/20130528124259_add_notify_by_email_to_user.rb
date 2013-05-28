class AddNotifyByEmailToUser < ActiveRecord::Migration
  def change
    add_column :users, :notify_by_email, :boolean,:default => true
  end
end
