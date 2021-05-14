class CreatePlaylistsTracks < ActiveRecord::Migration[6.1]
  def change
    create_table :playlists_tracks do |t|
    	t.belongs_to :song
    	t.belongs_to :playlist
      t.timestamps
    end
  end
end
