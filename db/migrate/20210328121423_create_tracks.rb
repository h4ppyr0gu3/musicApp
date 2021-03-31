class CreateTracks < ActiveRecord::Migration[6.1]
  def change
    create_table :tracks do |t|

    	t.string :track_name

    	t.references :user, :song
    	

      t.timestamps
    end
  end
end
