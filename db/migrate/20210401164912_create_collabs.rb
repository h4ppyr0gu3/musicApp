class CreateCollabs < ActiveRecord::Migration[6.1]
  def change
    create_table :collabs do |t|
    	t.references :artist, :song
      t.timestamps
    end
  end
end
