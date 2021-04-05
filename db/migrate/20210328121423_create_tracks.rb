class CreateTracks < ActiveRecord::Migration[6.1]
  def change
    create_table :tracks do |t|
    	t.belongs_to :song
    	t.belongs_to :user
      t.timestamps
    end
  end
end
