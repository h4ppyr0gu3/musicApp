class CreateSongs < ActiveRecord::Migration[6.1]
  def change
    create_table :songs do |t|

    	t.string :song_name
    	t.string :album_art_url
    	t.references :artist

      t.timestamps
    end
  end
end
