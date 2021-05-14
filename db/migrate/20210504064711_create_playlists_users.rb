class CreatePlaylistsUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :playlists_users do |t|
    	t.belongs_to :user
    	t.belongs_to :playlist
      t.timestamps
    end
  end
end
