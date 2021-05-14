class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
    	t.belongs_to :user
    	t.string :info
    	t.integer :status
      t.timestamps
    end
  end
end
