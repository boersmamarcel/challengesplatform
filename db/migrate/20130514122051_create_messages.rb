class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :subject
      t.text :body
      t.integer :sender_id
      t.integer :receiver_id
      t.boolean :is_read

      t.timestamps
    end
  end
end
