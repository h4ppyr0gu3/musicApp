class CreateFriendship < ActiveRecord::Migration[6.1]
  def change
    create_table :friendships do |t|
      t.integer :user_id
      t.integer :friend_id
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
