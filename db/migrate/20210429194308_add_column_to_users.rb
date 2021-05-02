class AddColumnToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :contributions, :integer, default: 0
    add_column :users, :playlists, :integer, default: 0
    add_column :users, :friends, :integer, default: 0
    add_column :users, :groups, :integer, default: 0
  end
end
