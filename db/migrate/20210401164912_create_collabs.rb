class CreateCollabs < ActiveRecord::Migration[6.1]
  def change
    create_table :collabs do |t|
    	t.belongs_to :song
      t.belongs_to :artist
      t.timestamps
    end
  end
end
